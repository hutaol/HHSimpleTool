//
//  HHGCDTimer.m
//  Pods
//
//  Created by Henry on 2022/2/22.
//

#import "HHGCDTimer.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

@implementation HHGCDTimer

static NSMutableDictionary *_hgt_timers;
dispatch_semaphore_t _hgt_semaphore;

+ (void)initialize {
    // GCD一次性函数
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _hgt_timers = [NSMutableDictionary dictionary];
        _hgt_semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(NSString *)group target:(id)aTarget task:(void (^)(NSString * _Nonnull))task {
    /**
     对参数做一些限制
     1.如果task不存在，那就没有执行的必要
     2.开始时间必须大于当前时间
     3.当需要重复执行时，重复间隔时间必须 >0
     以上条件必须满足，定时器才算是比较合理，否则没必要执行
     */
    if (!task || start < 0 || (repeats && interval <= 0)) return nil;
    
    /**
     队列
     async：YES 全局队列 dispatch_get_global_queue(0, 0) 可以简单理解为其他线程(非主线程)
     async：NO 主队列 dispatch_get_main_queue() 可以理解为主线程
     */
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);

    NSString *timerName = [NSString stringWithFormat:@"%@_%zd", group?:@"default", _hgt_timers.count];
    
    _hgt_timers[timerName] = @{@"timer": timer, @"status": @"0"}.mutableCopy;

    dispatch_semaphore_signal(_hgt_semaphore);

    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);

    // 使用weak，避免循环引用
    __weak typeof(aTarget) weakTarget = aTarget;
    dispatch_source_set_event_handler(timer, ^{
        if (!weakTarget) {
            [self cancelTimer:timerName];
            return;
        }
        
        // 定时任务
        task(timerName);
        // 如果不需要重复，执行一次即可
        if (!repeats) {
            [self cancelTimer:timerName];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return timerName;
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(NSString *)group target:(id)aTarget selector:(SEL)aSelector {
    /**
     对参数做一些限制
     1.如果target不存在，那就没有执行的必要
     2.开始时间必须大于当前时间
     3.当需要重复执行时，重复间隔时间必须 >0
     以上条件必须满足，定时器才算是比较合理，否则没必要执行
     */
    if (!aTarget || start < 0 || (repeats && interval <= 0)) return nil;
    
    /**
     队列
     async：YES 全局队列 dispatch_get_global_queue(0, 0) 可以简单理解为其他线程(非主线程)
     async：NO 主队列 dispatch_get_main_queue() 可以理解为主线程
     */
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);

    NSString *timerName = [NSString stringWithFormat:@"%@_%zd", group?:@"default", _hgt_timers.count];

    _hgt_timers[timerName] = @{@"timer": timer, @"status": @"0"}.mutableCopy;

    dispatch_semaphore_signal(_hgt_semaphore);

    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);

    __weak typeof(aTarget) weakTarget = aTarget;
    dispatch_source_set_event_handler(timer, ^{
        if (!weakTarget) {
            [self cancelTimer:timerName];
            return;
        }
        // 定时任务
        if (weakTarget && [weakTarget respondsToSelector:aSelector]) {
//            [aTarget performSelector:aSelector];
            // 消除⚠️
//            ((void (*)(id, SEL))[aTarget methodForSelector:aSelector])(aTarget, aSelector);
            
            SuppressPerformSelectorLeakWarning([weakTarget performSelector:aSelector withObject:timerName]);

        }
        
        // 如果不需要重复，执行一次即可
        if (!repeats) {
            [self cancelTimer:timerName];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return timerName;
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async task:(void (^)(NSString * _Nonnull))task {
    return [self timerStart:start interval:interval repeats:repeats async:async group:nil target:nil task:task];
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async group:(NSString *)group task:(void (^)(NSString * _Nonnull))task {
    return [self timerStart:start interval:interval repeats:repeats async:async group:group target:nil task:task];
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)aTarget task:(void (^)(NSString * _Nonnull))task {
    return [self timerStart:start interval:interval repeats:repeats async:async group:nil target:aTarget task:task];
}

+ (NSString *)timerStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)aTarget selector:(SEL)aSelector {
    return [self timerStart:start interval:interval repeats:repeats async:async group:nil target:aTarget selector:aSelector];
}

+ (void)cancelTimer:(NSString *)timerName {
    if (timerName.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    NSDictionary *data = _hgt_timers[timerName];
    dispatch_source_t timer = data[@"timer"];
    NSInteger status = [data[@"status"] integerValue];
    if (timer) {
        if (status == 1) {
            dispatch_resume(timer);
        }
        dispatch_source_cancel(timer);
        [_hgt_timers removeObjectForKey:timerName];
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)cancelTimerGroup:(NSString *)group {
    if (group.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        if ([timerName containsString:group]) {
            NSDictionary *data = _hgt_timers[timerName];
            dispatch_source_t timer = data[@"timer"];
            NSInteger status = [data[@"status"] integerValue];
            if (timer) {
                if (status == 1) {
                    dispatch_resume(timer);
                }
                dispatch_source_cancel(timer);
                [_hgt_timers removeObjectForKey:timerName];
            }
        }
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

/**
 dispatch_suspend dispatch_source_cancel 会导致崩溃
 */
+ (void)cancelAllTimer {
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        NSDictionary *data = _hgt_timers[timerName];
        dispatch_source_t timer = data[@"timer"];
        NSInteger status = [data[@"status"] integerValue];
        if (timer) {
            if (status == 1) {
                dispatch_resume(timer);
            }
            dispatch_source_cancel(timer);
        }
    }
    [_hgt_timers removeAllObjects];
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)pauseTimer:(NSString *)timerName {
    if (timerName.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *data = _hgt_timers[timerName];
    dispatch_source_t timer = data[@"timer"];
    if (timer) {
        data[@"status"] = @"1";
        dispatch_suspend(timer);
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)pauseTimerGroup:(NSString *)group {
    if (group.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        if ([timerName containsString:group]) {
            NSMutableDictionary *data = _hgt_timers[timerName];
            dispatch_source_t timer = data[@"timer"];
            if (timer) {
                data[@"status"] = @"1";
                dispatch_suspend(timer);
            }
        }
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)pauseAllTimer {
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        NSMutableDictionary *data = _hgt_timers[timerName];
        dispatch_source_t timer = data[@"timer"];
        if (timer) {
            data[@"status"] = @"1";
            dispatch_suspend(timer);
        }
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)resumeTimer:(NSString *)timerName {
    if (timerName.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *data = _hgt_timers[timerName];
    dispatch_source_t timer = data[@"timer"];
    NSInteger status = [data[@"status"] integerValue];
    if (timer && status != 0) {
        data[@"status"] = @"0";
        dispatch_resume(timer);
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)resumeTimerGroup:(NSString *)group {
    if (group.length == 0) {
        return;
    }
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        if ([timerName containsString:group]) {
            NSMutableDictionary *data = _hgt_timers[timerName];
            dispatch_source_t timer = data[@"timer"];
            NSInteger status = [data[@"status"] integerValue];
            if (timer && status != 0) {
                data[@"status"] = @"0";
                dispatch_resume(timer);
            }
        }
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

+ (void)resumeAllTimer {
    dispatch_semaphore_wait(_hgt_semaphore, DISPATCH_TIME_FOREVER);
    for (NSString *timerName in _hgt_timers) {
        NSMutableDictionary *data = _hgt_timers[timerName];
        dispatch_source_t timer = data[@"timer"];
        NSInteger status = [data[@"status"] integerValue];
        if (timer && status != 0) {
            data[@"status"] = @"0";
            dispatch_resume(timer);
        }
    }
    dispatch_semaphore_signal(_hgt_semaphore);
}

@end
