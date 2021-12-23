//
//  HHUtilities.m
//  Pods
//
//  Created by Henry on 2021/9/27.
//

#import "HHUtilities.h"
#import "UIWindow+HHHelper.h"

@implementation HHUtilities

/**
 全局设置 适配iOS11以上UITableview 、UICollectionView、UIScrollview 列表/页面偏移
 UIScrollViewContentInsetAdjustmentNever不计算内边距，不然系统会帮我们自动计算内边距，这样在滚动之后无法定位，会出现额外的内边距偏差
 然后在AppDelegate启动项目时，调用该方法，在didFinishLaunchingWithOptions中就能够完美的实现iOS11内边距偏移的适配
 */
+ (void)hh_adapterIOS11 {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];

        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
    }
}

+ (BOOL)hh_isIpad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (CGFloat)hh_statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)hh_navBarHeight {
    return [UIWindow topViewController].navigationController.navigationBar.frame.size.height;
}

+ (CGFloat)hh_statusNavHeight {
    return [self hh_statusBarHeight] + [self hh_navBarHeight];
}

+ (CGFloat)hh_topSafeHeight {
    return [self hh_safeAreaInset].top;
}

+ (CGFloat)hh_bottomSafeHeight {
    return [self hh_safeAreaInset].bottom;
}

+ (UIEdgeInsets)hh_safeAreaInset {
    if (@available(iOS 11.0, *)) {
        return [UIWindow hh_keyWindow].safeAreaInsets;
    } else {
        return UIEdgeInsetsMake([self hh_statusBarHeight], 0, 0, 0);
    }
}

@end
