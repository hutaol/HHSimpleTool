//
//  UIWindow+HHHelper.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHHelper)

/// 最上面viewController
- (UIViewController *)currentTopViewController;

/// window
+ (UIWindow *)hh_keyWindow;
/// 最上面viewController
+ (UIViewController *)topViewController;


/// 切换方向 (界面和设备)
/// 实现``UIApplicationDelegate``的``application:supportedInterfaceOrientationsForWindow:``方法 配合使用
/// !!!: iOS16 push页面不会马上生效（延迟0.1后push | `-viewDidLayoutSubviews`布局 | 自动布局）
+ (void)switchOrientation:(UIInterfaceOrientation)orientation;
/// 切换竖屏
+ (void)switchOrientationPortrait;
/// 切换横屏 home在右边
+ (void)switchOrientationLandscape;

/// 界面方向
+ (UIInterfaceOrientation)interfaceOrientation;
/// 是横屏
+ (BOOL)isLandscape;

@end

NS_ASSUME_NONNULL_END
