//
//  UIImage+HHTool.h
//  Pods
//
//  Created by Henry on 2022/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HHTool)

/// 通过颜色生成一张图片
+ (UIImage *)hh_imageWithColor:(UIColor *)color;
+ (UIImage *)hh_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 根据颜色生成一张带圆角的图片
+ (UIImage *)hh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

/// 给图片切割圆角
+ (UIImage *)hh_setCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;

/// 给图片设置色调
+ (UIImage *)hh_setTintColorWithImage:(UIImage *)image color:(UIColor *)color;

/// 调整图片大小
+ (UIImage *)hh_resizeImage:(UIImage *)image scaleToSize:(CGSize)size;
+ (UIImage *)hh_resizeImage:(UIImage *)image withNewSize:(CGSize)newSize;

/// 缩放图片大小
/// - Parameters:
///   - image: 图片
///   - imageLength: 最长边
+ (CGSize)hh_scaleSizeWithImage:(UIImage *)image withLength:(CGFloat)imageLength;
+ (CGSize)hh_scaleSizeWithSize:(CGSize)size withLength:(CGFloat)imageLength;
+ (UIImage *)hh_scaleImage:(UIImage *)image withLength:(CGFloat)imageLength;

@end

NS_ASSUME_NONNULL_END
