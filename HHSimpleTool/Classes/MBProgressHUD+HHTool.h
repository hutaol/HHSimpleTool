//
//  MBProgressHUD+HHTool.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

/**
 简单的封装MBProgressHUD，成功，失败提示，以及加载
 更多请参考：https://github.com/jdg/MBProgressHUD
 */
@interface MBProgressHUD (HHTool)

/// 加载
+ (void)show;
+ (void)show:(NSString *)message;
+ (void)show:(NSString *)message view:(nullable UIView *)view;

/// 成功
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success view:(nullable UIView *)view;
+ (void)showSuccess:(NSString *)success duration:(NSUInteger)time;
+ (void)showSuccess:(NSString *)success duration:(NSUInteger)time view:(nullable UIView *)view;

/// 错误
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error view:(nullable UIView *)view;
+ (void)showError:(NSString *)error duration:(NSUInteger)time;
+ (void)showError:(NSString *)error duration:(NSUInteger)time view:(nullable UIView *)view;

/// 信息
+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info view:(nullable UIView *)view;
+ (void)showInfo:(NSString *)info duration:(NSUInteger)time;
+ (void)showInfo:(NSString *)info duration:(NSUInteger)time view:(nullable UIView *)view;

/// 自定义提示
+ (void)showCustomIcon:(UIImage *)icon message:(NSString *)message duration:(NSUInteger)time view:(nullable UIView *)view;

/// 隐藏 window上
+ (void)hide;
+ (void)hideTop;
+ (void)hide:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
