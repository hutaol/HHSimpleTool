//
//  UIColor+HHTool.h
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HHTool)

+ (UIColor *)hh_fromShortHexValue:(NSUInteger)hex;
+ (UIColor *)hh_fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)hh_fromHexValue:(NSUInteger)hex;
+ (UIColor *)hh_fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)hh_colorWithString:(NSString *)string;

+ (UIColor *)hh_colorWithHex:(long)hex;
+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+ (UIColor *)hh_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

/// 常用颜色
+ (UIColor *)hh_whiteColor;
+ (UIColor *)hh_blockColor;

@end

NS_ASSUME_NONNULL_END
