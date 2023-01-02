//
//  HHReachabilityManager.h
//  Pods
//
//  Created by Henry on 2022/11/10.
//

#import <Foundation/Foundation.h>
#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHReachabilityStatus) {
    HHReachabilityStatusUnknown          = -1,
    HHReachabilityStatusNotReachable     = 0,
    HHReachabilityStatusReachableViaWiFi = 1,
    HHReachabilityStatusReachableVia2G   = 2,
    HHReachabilityStatusReachableVia3G   = 3,
    HHReachabilityStatusReachableVia4G   = 4,
    HHReachabilityStatusReachableVia5G   = 5
};

/// !!!: 在确定可达性状态之前，必须使用`-startMonitoring`启动`HHReachabilityManager`的实例
@interface HHReachabilityManager : NSObject

@property (readonly, nonatomic, assign) HHReachabilityStatus networkReachabilityStatus;

@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;


+ (instancetype)sharedManager;

+ (instancetype)manager;

+ (instancetype)managerForDomain:(NSString *)domain;

+ (instancetype)managerForAddress:(const void *)address;

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;

- (void)startMonitoring;

- (void)stopMonitoring;

- (void)setReachabilityStatusChangeBlock:(nullable void (^)(HHReachabilityStatus status))block;

@end

FOUNDATION_EXPORT NSString * const HHReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const HHReachabilityNotificationStatusItem;

NS_ASSUME_NONNULL_END
#endif
