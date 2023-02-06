//
//  MBProgressHUD+HHTool.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "MBProgressHUD+HHTool.h"
#import "UIWindow+HHHelper.h"
#import "HHDefine.h"

const NSInteger hh_hideTime = 2;

@implementation MBProgressHUD (HHTool)

+ (void)hh_show {
    [self hh_show:HHGetLocalLanguageTextValue(@"LoadingWaiting")];
}

+ (void)hh_show:(NSString *)message {
    [self hh_show:message view:nil];
}

+ (void)hh_show:(NSString *)message view:(UIView *)view {
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    MBProgressHUD *hud = [self hh_createMBProgressHUD:view];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
}

+ (void)hh_showSuccess:(NSString *)success {
    [self hh_showSuccess:success duration:hh_hideTime];
}

+ (void)hh_showSuccess:(NSString *)success view:(UIView *)view {
    [self hh_showSuccess:success duration:hh_hideTime view:view];
}

+ (void)hh_showSuccess:(NSString *)success duration:(NSUInteger)time {
    [self hh_showSuccess:success duration:time view:nil];
}

+ (void)hh_showSuccess:(NSString *)success duration:(NSUInteger)time view:(UIView *)view {
    [self hh_showCustomIcon:HHGetImageWithName(@"hud_success") message:success duration:time view:view];
}


+ (void)hh_showError:(NSString *)error {
    [self hh_showError:error duration:hh_hideTime];
}

+ (void)hh_showError:(NSString *)error view:(UIView *)view {
    [self hh_showError:error duration:hh_hideTime view:view];
}

+ (void)hh_showError:(NSString *)error duration:(NSUInteger)time {
    [self hh_showError:error duration:time view:nil];
}

+ (void)hh_showError:(NSString *)error duration:(NSUInteger)time view:(UIView *)view {
    [self hh_showCustomIcon:HHGetImageWithName(@"hud_error") message:error duration:time view:view];
}


+ (void)hh_showInfo:(NSString *)info {
    [self hh_showInfo:info view:nil];
}

+ (void)hh_showInfo:(NSString *)info view:(UIView *)view {
    [self hh_showInfo:info duration:hh_hideTime view:view];
}

+ (void)hh_showInfo:(NSString *)info duration:(NSUInteger)time {
    [self hh_showInfo:info duration:time view:nil];
}

+ (void)hh_showInfo:(NSString *)info duration:(NSUInteger)time view:(UIView *)view {
    [self hh_showCustomIcon:HHGetImageWithName(@"hud_info") message:info duration:time view:view];
}


+ (void)hh_showCustomIcon:(UIImage *)icon message:(NSString *)message duration:(NSUInteger)time view:(UIView *)view {
    if (!icon) {
        return;
    }
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    MBProgressHUD *hud = [self hh_createMBProgressHUD:view];
    hud.label.text = message;
    hud.customView = [[UIImageView alloc] initWithImage:icon];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:time];
}

+ (MBProgressHUD *)hh_createMBProgressHUD:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.minSize = CGSizeMake(100, 100);
    hud.label.font = [UIFont systemFontOfSize:17];
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor whiteColor];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)hh_hide {
    [self hh_hide:nil];
}

+ (void)hh_hideTop {
    UIView *view = [UIWindow topViewController].view;
    [self hh_hide:view];
}

+ (void)hh_hide:(UIView *)view {
    if (!view) {
        view = [UIWindow hh_keyWindow];
    }
    [self hideHUDForView:view animated:YES];
}

@end
