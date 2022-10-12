//
//  NSString+HHTool.m
//  Pods
//
//  Created by Henry on 2022/10/11.
//

#import "NSString+HHTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (HHTool)

- (NSString *)hh_md5String {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self hh_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hh_stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

+ (BOOL)hh_isEmpty:(NSString *)str {
    if (!str ||
        [str isKindOfClass:[NSNull class]] ||
        !str.length ||
        ![str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length ||
        [str isEqualToString:@"<null>"] ||
        [str isEqualToString:@"(null)"] ||
        [str isEqualToString:@"null"] ||
        [str isEqualToString:@"nil"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)hh_isNotEmpty:(NSString *)str {
    return ![self hh_isEmpty:str];
}

- (BOOL)hh_isEmpty {
    return [NSString hh_isEmpty:self];
}

- (BOOL)hh_isNotEmpty {
    return ![self hh_isEmpty];
}

- (NSString *)hh_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)hh_UUID {
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)hh_uuid {
    return [[self hh_UUID] lowercaseString];
}

#pragma mark - 计算文本大小

- (CGSize)hh_textSizeInFont:(UIFont *)font {
    return [self hh_textSizeIn:CGSizeZero font:font breakMode:NSLineBreakByWordWrapping align:NSTextAlignmentLeft];
}

- (CGSize)hh_textSizeInWidth:(CGFloat)width font:(UIFont *)font {
    return [self hh_textSizeIn:CGSizeMake(width, 0) font:font];
}

- (CGSize)hh_textSizeIn:(CGSize)size font:(UIFont *)font {
    return [self hh_textSizeIn:size font:font breakMode:NSLineBreakByWordWrapping align:NSTextAlignmentLeft];
}

- (CGSize)hh_textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)abreakMode align:(NSTextAlignment)alignment {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = abreakMode;
    style.alignment = alignment;

    NSDictionary *attributes = @{
        NSFontAttributeName:font,
        NSParagraphStyleAttributeName:style
    };
    
    // 用相对小的 width 去计算 height / 小 heigth 算 width
    resultSize = [self boundingRectWithSize:CGSizeMake(floor(size.width), floor(size.height)) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil].size;
    // 上面用的小 width（height） 来计算了，这里要 +1
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));
    return resultSize;
}

+ (CGSize)hh_textSizeIn:(CGSize)size attrString:(NSAttributedString *)attrString {
    CGSize resultSize = CGSizeZero;
    if (!attrString) {
        return resultSize;
    }
    // 用相对小的 width 去计算 height / 小 heigth 算 width
    resultSize = [attrString boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    // 上面用的小 width（height） 来计算了，这里要 +1
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));
    return resultSize;
}

+ (CGSize)hh_textSizeInWidth:(CGFloat)width attrString:(NSAttributedString *)attrString {
    return [self hh_textSizeIn:CGSizeMake(width, 0) attrString:attrString];
}

@end
