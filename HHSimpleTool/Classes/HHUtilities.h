//
//  HHUtilities.h
//  Pods
//
//  Created by Henry on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHUtilities : NSObject

/// 《慎用》全局设置 适配iOS11以上UITableview 、UICollectionView、UIScrollview 列表/页面偏移
+ (void)hh_adapterIOS11;

+ (BOOL)hh_isIpad;

+ (CGFloat)hh_statusBarHeight;
+ (CGFloat)hh_navBarHeight;
+ (CGFloat)hh_statusNavHeight;
+ (CGFloat)hh_topSafeHeight;
+ (CGFloat)hh_bottomSafeHeight;
+ (UIEdgeInsets)hh_safeAreaInset;

@end

NS_ASSUME_NONNULL_END
