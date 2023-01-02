//
//  HHReachabilityManager.m
//  Pods
//
//  Created by Henry on 2022/11/10.
//

#import "HHReachabilityManager.h"
#if !TARGET_OS_WATCH
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NSString * const HHReachabilityDidChangeNotification = @"com.Henry.reachability.change";
NSString * const HHReachabilityNotificationStatusItem = @"HHNetworkingReachabilityNotificationStatusItem";

typedef void (^HHReachabilityStatusBlock)(HHReachabilityStatus status);

static HHReachabilityStatus HHReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    HHReachabilityStatus status = HHReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = HHReachabilityStatusNotReachable;
    }
#if TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
        NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
        if (@available(iOS 12.1, *)) {
            if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
                NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
                if (radioDic.allKeys.count) {
                    currentRadioAccessTechnology = [radioDic objectForKey:radioDic.allKeys[0]];
                }
            }
        }
        if (currentRadioAccessTechnology) {
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]
                || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]
                || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
                status = HHReachabilityStatusReachableVia2G;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
                status = HHReachabilityStatusReachableVia3G;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                status = HHReachabilityStatusReachableVia4G;
            } else if (@available(iOS 14.1, *)) {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNRNSA]
                    || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNR]) {
                    status = HHReachabilityStatusReachableVia5G;
                }
            } else {
                status = HHReachabilityStatusUnknown;
            }
        }
    }
#endif
    else {
        status = HHReachabilityStatusReachableViaWiFi;
    }
    return status;
    
}

static void HHPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, HHReachabilityStatusBlock block) {
    HHReachabilityStatus status = HHReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) block(status);
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSMutableDictionary *userInfo = @{}.mutableCopy;
        userInfo[HHReachabilityNotificationStatusItem] = @(status);
        
        [notificationCenter postNotificationName:HHReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}

static void HHPlayerReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    HHPostReachabilityStatusChange(flags, (__bridge HHReachabilityStatusBlock)info);
}

static const void * HHReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}

static void HHReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}

@interface HHReachabilityManager ()

@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) HHReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) HHReachabilityStatusBlock networkReachabilityStatusBlock;

@end

@implementation HHReachabilityManager

+ (instancetype)sharedManager {
    static HHReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    return _sharedManager;
}

+ (instancetype)manager {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}

+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    HHReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}

+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    HHReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = HHReachabilityStatusUnknown;
    
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
        self.networkReachabilityStatus = HHReachabilityStatusForFlags(flags);
    }
    return self;
}

- (instancetype)init NS_UNAVAILABLE {
    return nil;
}

- (void)dealloc {
    [self stopMonitoring];
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

#pragma mark -

- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return (self.networkReachabilityStatus == HHReachabilityStatusReachableVia2G ||self.networkReachabilityStatus == HHReachabilityStatusReachableVia3G || self.networkReachabilityStatus == HHReachabilityStatusReachableVia4G);
}

- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == HHReachabilityStatusReachableViaWiFi;
}

#pragma mark -

- (void)startMonitoring {
    [self stopMonitoring];
    if (!self.networkReachability) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    HHReachabilityStatusBlock callback = ^(HHReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, HHReachabilityRetainCallback, HHReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, HHPlayerReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            HHPostReachabilityStatusChange(flags, callback);
        }
    });
}

- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

#pragma mark -

- (void)setReachabilityStatusChangeBlock:(void (^)(HHReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}

#pragma mark - NSKeyValueObserving

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end
#endif
