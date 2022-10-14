//
//  UIWindow+HHHelper.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "UIWindow+HHHelper.h"

@implementation UIWindow (HHHelper)

+ (UIWindow *)hh_keyWindow {
    __block UIWindow *window;
    if (@available(iOS 13, *)) {
        [[UIApplication sharedApplication].connectedScenes enumerateObjectsUsingBlock:^(UIScene * _Nonnull scene, BOOL * _Nonnull scenesStop) {
            if ([scene isKindOfClass: [UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                [windowScene.windows enumerateObjectsUsingBlock:^(UIWindow * _Nonnull windowTemp, NSUInteger idx, BOOL * _Nonnull windowStop) {
                    if (windowTemp.isKeyWindow) {
                        window = windowTemp;
                        *windowStop = YES;
                        *scenesStop = YES;
                    }
                }];
            }
        }];
    } else {
        window = [[UIApplication sharedApplication].delegate window];
    }
    return window;
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


+ (void)switchOrientation:(UIInterfaceOrientation)orientation {
    if (@available(iOS 16.0, *)) {
        UIViewController *viewController = [self topViewController];
        [viewController setNeedsUpdateOfSupportedInterfaceOrientations];
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *scene = [array firstObject];
        UIInterfaceOrientationMask orientationMask = [self _orientationMask:orientation];
        UIWindowSceneGeometryPreferencesIOS *geometryPreferencesIOS = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:orientationMask];
        [scene requestGeometryUpdateWithPreferences:geometryPreferencesIOS errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"switch orientation error: %@", error);
        }];
    } else {
        [self _interfaceOrientation:UIInterfaceOrientationUnknown];
        [self _interfaceOrientation:orientation];
    }
}

+ (void)switchOrientationPortrait {
    [self switchOrientation:UIInterfaceOrientationPortrait];
}

+ (void)switchOrientationLandscape {
    UIInterfaceOrientation orientation = [self interfaceOrientation];
    if (orientation == UIInterfaceOrientationUnknown || orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        orientation = UIInterfaceOrientationLandscapeRight;
    }
    [self switchOrientation:orientation];
}

+ (void)_interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        UIInterfaceOrientation val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

+ (UIInterfaceOrientationMask)_orientationMask:(UIInterfaceOrientation)orientation {
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            mask = UIInterfaceOrientationMaskLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            mask = UIInterfaceOrientationMaskLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            mask = UIInterfaceOrientationMaskPortraitUpsideDown;
            break;
        default:
            break;
    }
    return mask;
}

+ (UIInterfaceOrientation)interfaceOrientation {
    if (@available(iOS 13.0, *)) {
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *scene = [array firstObject];
        return scene.interfaceOrientation;
    } else {
        return [UIApplication sharedApplication].statusBarOrientation;
    }
}

+ (BOOL)isLandscape {
    UIInterfaceOrientation orientation = [self interfaceOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

@end
