//
//  HHGCDTimer.h
//  Pods
//
//  Created by Henry on 2022/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHGCDTimer : NSObject

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void(^)(NSString *timerName))task;

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)aTarget selector:(SEL)aSelector;

+ (void)cancelTimer:(NSString *)timerName;

@end

NS_ASSUME_NONNULL_END
