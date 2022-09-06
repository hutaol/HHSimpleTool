//
//  UIColor+HHTool.m
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import "UIColor+HHTool.h"

@implementation UIColor (HHTool)

+ (UIColor *)hh_fromShortHexValue:(NSUInteger)hex {
    return [UIColor hh_fromShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)hh_fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha {
    NSUInteger r = ((hex >> 8) & 0x0000000F);
    NSUInteger g = ((hex >> 4) & 0x0000000F);
    NSUInteger b = ((hex >> 0) & 0x0000000F);
    
    float fr = (r * 1.0f) / 15.0f;
    float fg = (g * 1.0f) / 15.0f;
    float fb = (b * 1.0f) / 15.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)hh_fromHexValue:(NSUInteger)hex {
    NSUInteger a = ((hex >> 24) & 0x000000FF);
    float fa = ((0 == a) ? 1.0f : (a * 1.0f) / 255.0f);

    return [UIColor hh_fromHexValue:hex alpha:fa];
}

+ (UIColor *)hh_fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha {
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);
    
    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)hh_colorWithString:(NSString *)string {
    if (string == nil || string.length == 0 )
        return nil;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string hasPrefix:@"rgb("] && [string hasSuffix:@")"]) {
        string = [string substringWithRange:NSMakeRange(4, string.length - 5)];
        if (string && string.length) {
            NSArray *elems = [string componentsSeparatedByString:@","];
            if (elems && elems.count == 3) {
                NSInteger r = [[elems objectAtIndex:0] integerValue];
                NSInteger g = [[elems objectAtIndex:1] integerValue];
                NSInteger b = [[elems objectAtIndex:2] integerValue];
                return [UIColor colorWithRed:(r * 1.0f / 255.0f) green:(g * 1.0f / 255.0f) blue:(b * 1.0f / 255.0f) alpha:1.0f];
            }
        }
    }
    
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *color = [array objectAtIndex:0];
    CGFloat alpha = 1.0f;

    if (array.count == 2) {
        alpha = [[array objectAtIndex:1] floatValue];
    }

    if ([color hasPrefix:@"#"]) {
        color = [color substringFromIndex:1];

        if (color.length == 3) {
            NSUInteger hexRGB = strtol(color.UTF8String, nil, 16);
            return [UIColor hh_fromShortHexValue:hexRGB alpha:alpha];
        } else if (color.length == 6) {
            NSUInteger hexRGB = strtol(color.UTF8String, nil, 16);
            return [UIColor hh_fromHexValue:hexRGB alpha:alpha];
        }
    } else if ([color hasPrefix:@"0x"] || [color hasPrefix:@"0X"]) {
        color = [color substringFromIndex:2];
        
        if (color.length == 8){
            NSUInteger hexRGB = strtol(color.UTF8String, nil, 16);
            return [UIColor hh_fromHexValue:hexRGB];
        } else if (color.length == 6) {
            NSUInteger hexRGB = strtol(color.UTF8String, nil, 16);
            return [UIColor hh_fromHexValue:hexRGB alpha:1.0f];
        }
    }

    return nil;

}

+ (UIColor *)hh_colorWithHex:(long)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8)  & 0xFF;
    int b = hex & 0xFF;
    return [UIColor hh_colorWithIntegerRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)hh_colorWithIntegerRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    CGFloat fRed   = (CGFloat)red;
    CGFloat fGreen = (CGFloat)green;
    CGFloat fBlue  = (CGFloat)blue;
    return [UIColor colorWithRed:fRed / 255.0 green:fGreen / 255.0 blue:fBlue / 255.0 alpha:alpha];
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

+ (UIColor *)hh_whiteColor {
    return [self hh_colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
}

+ (UIColor *)hh_blockColor {
    return [self hh_colorWithLightColor:[UIColor blackColor] darkColor:[UIColor whiteColor]];
}

@end
