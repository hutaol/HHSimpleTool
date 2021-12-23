//
//  UIWindow+HHHelper.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "UIWindow+HHHelper.h"

@implementation UIWindow (HHHelper)

+ (UIWindow *)hh_keyWindow {
    if (@available(iOS 13.0, *)) {
        UIWindow *foundWindow = nil;
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            if (window.isKeyWindow) {
                foundWindow = window;
                break;
            }
        }
        if (foundWindow == nil) {
            if (windows.count > 0) {
                foundWindow = windows[0];
            }
        }
        return foundWindow;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)topViewController {
    return [self hh_keyWindow].currentTopViewController;
}

- (UIViewController *)topRootController {
    UIViewController *topController = [self rootViewController];
    
    while ([topController presentedViewController])
        topController = [topController presentedViewController];
    
    return topController;
}

- (UIViewController *)presentedWithController:(UIViewController *)vc {
    while ([vc presentedViewController])
        vc = vc.presentedViewController;
    return vc;
}

- (UIViewController *)currentTopViewController {
    UIViewController *currentViewController = [self topRootController];
    if ([currentViewController isKindOfClass:[UITabBarController class]] && ((UITabBarController *)currentViewController).selectedViewController != nil ) {
        currentViewController = ((UITabBarController *)currentViewController).selectedViewController;
    }
    
    currentViewController = [self presentedWithController:currentViewController];

    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
        currentViewController = [self presentedWithController:currentViewController];
    }
    
    currentViewController = [self presentedWithController:currentViewController];

    return currentViewController;
}

@end
