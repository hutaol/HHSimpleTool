//
//  UIColor+HHTool.m
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import "UIColor+HHTool.h"
#import "UIImage+HHTool.h"

CGFloat hh_colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (HHTool)

+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [self hh_colorWithIntegerRed:red green:green blue:blue alpha:1.f];
}

+ (UIColor *)hh_colorWithHex:(UInt32)hex {
    return [UIColor hh_colorWithHex:hex alpha:1];
}

+ (UIColor *)hh_colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    int red = (hex >> 16) & 0xFF;
    int green = (hex >> 8)  & 0xFF;
    int blue = hex & 0xFF;
    return [UIColor hh_colorWithIntegerRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)hh_colorWithHexString:(NSString *)hexString {
    return [self hh_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)hh_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    colorString = [colorString stringByReplacingOccurrencesOfString:@"0X" withString:@""];

    CGFloat red, green, blue;
    
    switch ([colorString length]) {
        case 3: // #RGB
            red   = hh_colorComponentFrom(colorString, 0, 1);
            green = hh_colorComponentFrom(colorString, 1, 1);
            blue  = hh_colorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = hh_colorComponentFrom(colorString, 0, 1);
            red   = hh_colorComponentFrom(colorString, 1, 1);
            green = hh_colorComponentFrom(colorString, 2, 1);
            blue  = hh_colorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            red   = hh_colorComponentFrom(colorString, 0, 2);
            green = hh_colorComponentFrom(colorString, 2, 2);
            blue  = hh_colorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = hh_colorComponentFrom(colorString, 0, 2);
            red   = hh_colorComponentFrom(colorString, 2, 2);
            green = hh_colorComponentFrom(colorString, 4, 2);
            blue  = hh_colorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)hh_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ( traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight ) {
                return lightColor;
            } else if ( traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size start:(CGPoint)start end:(CGPoint)end {
    UIImage *image = [UIImage hh_gradientWithColors:colors size:size start:start end:end];
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size axis:(UILayoutConstraintAxis)axis {
    UIImage *image = [UIImage hh_gradientWithColors:colors size:size axis:axis];
    return [UIColor colorWithPatternImage:image];
}
+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors width:(CGFloat)width {
    UIImage *image = [UIImage hh_gradientWithColors:colors width:width];
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)hh_gradientWithColors:(NSArray<UIColor *> *)colors height:(CGFloat)height {
    UIImage *image = [UIImage hh_gradientWithColors:colors height:height];
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 width:(CGFloat)width {
    UIImage *image = [UIImage hh_gradientFromColor:c1 toColor:c2 width:width];
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)hh_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 height:(CGFloat)height {
    UIImage *image = [UIImage hh_gradientFromColor:c1 toColor:c2 height:height];
    return [UIColor colorWithPatternImage:image];
}


+ (UIColor *)hh_whiteColor {
    return [self hh_colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
}

+ (UIColor *)hh_blockColor {
    return [self hh_colorWithLightColor:[UIColor blackColor] darkColor:[UIColor whiteColor]];
}

+ (UIColor *)hh_randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    return [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
}

- (NSString *)hh_HEXString {
    UIColor *color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

@end
