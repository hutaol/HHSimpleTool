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

/// 渐变色生成渐变图片
+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size start:(CGPoint)start end:(CGPoint)end;
/// - Parameter axis 方向
+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size axis:(UILayoutConstraintAxis)axis;
/// 从左到右
+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors width:(CGFloat)width;
/// 从上到下
+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors height:(CGFloat)height;
/// 2点
+ (UIImage *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 width:(CGFloat)width;
+ (UIImage *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 height:(CGFloat)height;

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

/// 压缩图片大小
/// - Parameters:
///   - image: 图片
///   - dataSize: 压缩后最大字节大小
///   - imageLength: 最长边 >0才有效
+ (NSData *)hh_compressImage:(UIImage *)image dataSize:(NSInteger)dataSize withLength:(CGFloat)imageLength;
+ (NSData *)hh_compressImage:(UIImage *)image dataSize:(NSInteger)dataSize;

+ (UIImage *)hh_compressImageWithImage:(UIImage *)image dataSize:(NSInteger)dataSize withLength:(CGFloat)imageLength;
+ (UIImage *)hh_compressImageWithImage:(UIImage *)image dataSize:(NSInteger)dataSize;


/// 获取视频图片
/// - Parameters:
///   - videoURL: 视频URL
///   - time: 秒
///   - completion: 回调
+ (void)imageWithVideoURL:(nullable NSURL *)videoURL time:(NSTimeInterval)time completion:(void(^)(UIImage * _Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
