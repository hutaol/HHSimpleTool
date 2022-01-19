//
//  UIImageView+HHCornerRadius.h
//  HHTool
//
//  Created by Henry on 2021/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 参考：https://github.com/liuzhiyi1992/ZYCornerRadius
/// TODO: 后设置图片(Image)才生效
@interface UIImageView (HHCornerRadius)

/// 圆角
/// @param cornerRadius 大小
/// @param rectCorner 位置
- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner;

/// 圆角
/// @param cornerRadius 大小  <0 圆形
- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius;

/// 圆形
- (instancetype)initWithRoundRect;

/// 圆角
/// @param cornerRadius 大小
/// @param rectCorner 位置
- (void)hh_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner;

/// 圆角
/// @param cornerRadius 大小 <0 圆形
- (void)hh_cornerRadius:(CGFloat)cornerRadius;

/// 圆形
- (void)hh_cornerRadiusRoundRect;

/// 边框
/// @param width 宽度
/// @param color 颜色
- (void)hh_borderWidth:(CGFloat)width color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
