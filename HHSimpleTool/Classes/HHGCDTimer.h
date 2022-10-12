//
//  HHGCDTimer.h
//  Pods
//
//  Created by Henry on 2022/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// gcd timer
@interface HHGCDTimer : NSObject

/// 倒计时
/// - Parameters:
///   - start: 开始
///   - interval: 间隔
///   - repeats: 重复
///   - async: 异步
///   - group: 组 默认：default
///   - aTarget: target
///   - task: 回调
+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(nullable NSString *)group target:(nullable id)aTarget task:(void(^)(NSString *timerName))task;

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(nullable NSString *)group target:(id)aTarget selector:(SEL)aSelector;

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void(^)(NSString *timerName))task;

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(nullable NSString *)group task:(void(^)(NSString *timerName))task;
+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)aTarget task:(void(^)(NSString *timerName))task;

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)aTarget selector:(SEL)aSelector;

/// 取消
+ (void)cancelTimer:(NSString *)timerName;
+ (void)cancelTimerGroup:(NSString *)group;
+ (void)cancelAllTimer;

/// 暂停
+ (void)pauseTimer:(NSString *)timerName;
+ (void)pauseTimerGroup:(NSString *)group;
+ (void)pauseAllTimer;

/// 继续
+ (void)resumeTimer:(NSString *)timerName;
+ (void)resumeTimerGroup:(NSString *)group;
+ (void)resumeAllTimer;

@end

NS_ASSUME_NONNULL_END
