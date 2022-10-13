//
//  UIImage+HHTool.m
//  Pods
//
//  Created by Henry on 2022/10/11.
//

#import "UIImage+HHTool.h"

@implementation UIImage (HHTool)

+ (UIImage *)hh_imageWithColor:(UIColor *)color {
    return [self hh_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)hh_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color) color = [UIColor whiteColor];
    if (CGSizeEqualToSize(size, CGSizeZero)) size = CGSizeMake(1, 1);
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)hh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    UIImage *image = [self hh_imageWithColor:color size:size];
    return [self hh_setCornerWithImage:image cornerRadius:cornerRadius];
}

/// 渐变色
+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size start:(CGPoint)start end:(CGPoint)end {
    if (colors.count == 0) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (UIColor *c in colors) {
        [arr addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)arr, NULL);
    
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size axis:(UILayoutConstraintAxis)axis {
    CGPoint start;
    CGPoint end;
    
    switch (axis) {
        case UILayoutConstraintAxisHorizontal:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case UILayoutConstraintAxisVertical:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    return [self hh_gradientWithColors:colors size:size start:start end:end];
}

+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors width:(CGFloat)width {
    return [self hh_gradientWithColors:colors size:CGSizeMake(width, 1) axis:UILayoutConstraintAxisHorizontal];
}

+ (UIImage *)hh_gradientWithColors:(NSArray<UIColor *> *)colors height:(CGFloat)height {
    return [self hh_gradientWithColors:colors size:CGSizeMake(1, height) axis:UILayoutConstraintAxisVertical];
}

+ (UIImage *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 width:(CGFloat)width {
    if (!c1 || !c2) return nil;
    return [self hh_gradientWithColors:@[c1, c2] width:width];
}

+ (UIImage *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 height:(CGFloat)height {
    if (!c1 || !c2) return nil;
    return [self hh_gradientWithColors:@[c1, c2] height:height];
}

+ (UIImage *)hh_setCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)hh_setTintColorWithImage:(UIImage *)image color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)hh_resizeImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)hh_resizeImage:(UIImage *)image withNewSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CGSize)hh_scaleSizeWithImage:(UIImage *)image withLength:(CGFloat)imageLength {
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageLength || height > imageLength) {
        if (width > height) {
            newWidth = imageLength;
            newHeight = newWidth * height / width;
        } else if(height > width) {
            newHeight = imageLength;
            newWidth = newHeight * width / height;
        } else {
            newWidth = imageLength;
            newHeight = imageLength;
        }
    } else {
        return CGSizeMake(width, height);
    }
    return CGSizeMake(newWidth, newHeight);
}

+ (CGSize)hh_scaleSizeWithSize:(CGSize)size withLength:(CGFloat)imageLength {
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if (width > imageLength || height > imageLength) {
        if (width > height) {
            newWidth = imageLength;
            newHeight = newWidth * height / width;
        } else if(height > width) {
            newHeight = imageLength;
            newWidth = newHeight * width / height;
        } else {
            newWidth = imageLength;
            newHeight = imageLength;
        }
    } else {
        return CGSizeMake(width, height);
    }
    return CGSizeMake(newWidth, newHeight);
}

+ (UIImage *)hh_scaleImage:(UIImage *)image withLength:(CGFloat)imageLength {
    CGSize size = [self hh_scaleSizeWithImage:image withLength:imageLength];
    return [self hh_resizeImage:image withNewSize:size];
}

@end
