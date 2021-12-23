//
//  HHToastTool.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "HHToastTool.h"
#import "UIWindow+HHHelper.h"
#import <Toast/Toast.h>

@implementation HHToastTool

+ (void)show:(NSString *)message {
    [self show:message position:HHToastToolPositionCenter showTime:2.0];
}

+ (void)showAtTop:(NSString *)message {
    [self show:message position:HHToastToolPositionTop showTime:2.0];
}

+ (void)showAtCenter:(NSString *)message {
    [self show:message position:HHToastToolPositionCenter showTime:2.0];
}

+ (void)showAtBottom:(NSString *)message {
    [self show:message position:HHToastToolPositionBottom showTime:2.0];
}

+ (void)showLong:(NSString *)message {
    [self show:message position:HHToastToolPositionCenter showTime:4.0];
}

+ (void)showLongAtTop:(NSString *)message {
    [self show:message position:HHToastToolPositionTop showTime:4.0];
}

+ (void)showLongAtCenter:(NSString *)message {
    [self show:message position:HHToastToolPositionCenter showTime:4.0];
}

+ (void)showLongAtBottom:(NSString *)message {
    [self show:message position:HHToastToolPositionBottom showTime:4.0];
}

+ (void)show:(NSString *)message position:(HHToastToolPosition)position showTime:(float)showTime {
    [self show:message position:position showTime:showTime view:nil];
}

+ (void)show:(NSString *)message position:(HHToastToolPosition)position showTime:(float)showTime view:(UIView *)view {
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    
    switch ((int)position) {
        case HHToastToolPositionBottom:
            [view makeToast:message duration:showTime position:CSToastPositionBottom];
            break;
        case HHToastToolPositionTop:
            [view makeToast:message duration:showTime position:CSToastPositionTop];
            break;
        case HHToastToolPositionCenter:
            [view makeToast:message duration:showTime position:CSToastPositionCenter];
            break;
            
        default:
            break;
    }
}

+ (void)show:(NSString *)message point:(CGPoint)point showTime:(float)showTime view:(UIView *)view {
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    
    NSValue *value = [NSValue valueWithCGPoint:point];
    [view makeToast:message duration:showTime position:value];

}

+ (void)showActivity:(UIView *)view {
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    [view makeToastActivity:CSToastPositionCenter];
}

@end
