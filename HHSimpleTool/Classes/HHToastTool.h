//
//  HHToastTool.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHToastToolPosition) {
    HHToastToolPositionBottom,
    HHToastToolPositionCenter,
    HHToastToolPositionTop,
};

@interface HHToastTool : NSObject

/// 显示提示视图, 默认显示在屏幕中间，2s后自动消失
+ (void)show:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕上方，防止被软键盘覆盖，2s后自动消失
+ (void)showAtTop:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕中间，2s后自动消失
+ (void)showAtCenter:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕底部，2s后自动消失
+ (void)showAtBottom:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕中间，4s后自动消失
+ (void)showLong:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕上方，防止被软键盘覆盖，4s后自动消失
+ (void)showLongAtTop:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕中间，4s后自动消失
+ (void)showLongAtCenter:(NSString *)message;

/// 显示提示视图, 默认显示在屏幕底部，4s后自动消失
+ (void)showLongAtBottom:(NSString *)message;

/// 显示提示视图
/// @param message 提示内容
/// @param position @HHToastToolPosition
/// @param showTime 显示时间s
/// @param view 父视图，view=nil显示在window上
+ (void)show:(NSString *)message position:(HHToastToolPosition)position showTime:(float)showTime view:(nullable UIView *)view;

/// 显示提示视图，window
+ (void)show:(NSString *)message position:(HHToastToolPosition)position showTime:(float)showTime;

/// 显示提示视图，point 中心点
+ (void)show:(NSString *)message point:(CGPoint)point showTime:(float)showTime view:(nullable UIView *)view;

/// 加载view
+ (void)showActivity:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
