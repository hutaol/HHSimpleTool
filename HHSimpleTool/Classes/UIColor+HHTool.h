//
//  UIColor+HHTool.h
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HHTool)

/// 设置颜色 rgb
+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/// 设置颜色 0xFFFFFF
+ (UIColor *)hh_colorWithHex:(UInt32)hex;
+ (UIColor *)hh_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;
/// - Parameter hexString: "#FFFFFF" "FFFFFF" "0xFFFFFF"
+ (UIColor *)hh_colorWithHexString:(NSString *)hexString;
+ (UIColor *)hh_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


/// 暗黑模式
+ (UIColor *)hh_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;


/// 渐变颜色
+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size start:(CGPoint)start end:(CGPoint)end;
/// - Parameter axis 方向
+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size axis:(UILayoutConstraintAxis)axis;
/// 从左到右
+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors width:(CGFloat)width;
/// 从上到下
+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors height:(CGFloat)height;
/// 2点
+ (UIColor *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 width:(CGFloat)width;
+ (UIColor *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 height:(CGFloat)height;


/// 常用颜色
+ (UIColor *)hh_whiteColor;
+ (UIColor *)hh_blockColor;
/// 随机颜色
+ (UIColor *)hh_randomColor;

/// #FFFFFF
- (NSString *)hh_HEXString;

@end

NS_ASSUME_NONNULL_END
