//
//  UIWindow+HHHelper.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHHelper)

- (UIViewController *)currentTopViewController;

+ (UIWindow *)hh_keyWindow;

+ (UIViewController *)topViewController;


@end

NS_ASSUME_NONNULL_END
