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
+ (void)hh_show;
+ (void)hh_show:(NSString *)message;
+ (void)hh_show:(NSString *)message view:(nullable UIView *)view;

/// 成功
+ (void)hh_showSuccess:(NSString *)success;
+ (void)hh_showSuccess:(NSString *)success view:(nullable UIView *)view;
+ (void)hh_showSuccess:(NSString *)success duration:(NSUInteger)time;
+ (void)hh_showSuccess:(NSString *)success duration:(NSUInteger)time view:(nullable UIView *)view;

/// 错误
+ (void)hh_showError:(NSString *)error;
+ (void)hh_showError:(NSString *)error view:(nullable UIView *)view;
+ (void)hh_showError:(NSString *)error duration:(NSUInteger)time;
+ (void)hh_showError:(NSString *)error duration:(NSUInteger)time view:(nullable UIView *)view;

/// 信息
+ (void)hh_showInfo:(NSString *)info;
+ (void)hh_showInfo:(NSString *)info view:(nullable UIView *)view;
+ (void)hh_showInfo:(NSString *)info duration:(NSUInteger)time;
+ (void)hh_showInfo:(NSString *)info duration:(NSUInteger)time view:(nullable UIView *)view;

/// 自定义提示
+ (void)hh_showCustomIcon:(UIImage *)icon message:(NSString *)message duration:(NSUInteger)time view:(nullable UIView *)view;

/// 隐藏 window上
+ (void)hh_hide;
/// 隐藏 topViewController上
+ (void)hh_hideTop;
/// 隐藏 view上
+ (void)hh_hide:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
