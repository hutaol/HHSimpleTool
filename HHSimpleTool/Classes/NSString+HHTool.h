//
//  NSString+HHTool.h
//  Pods
//
//  Created by Henry on 2022/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HHTool)

/// md5 32长度
/// 终端命令：md5 -s "123"
@property (readonly) NSString *hh_md5String;

/// 判断是否为空
+ (BOOL)hh_isEmpty:(NSString *)str;
+ (BOOL)hh_isNotEmpty:(NSString *)str;
- (BOOL)hh_isEmpty;
- (BOOL)hh_isNotEmpty;

/// 去掉首尾空格及换行
- (NSString *)hh_trim;
- (NSString *)hh_trimmingWhitespace;
- (NSString *)hh_trimmingWhitespaceAndNewlines;

/// UUID
+ (NSString *)hh_UUID;
/// 小写字母
+ (NSString *)hh_uuid;


#pragma mark - 计算文本大小

/// 计算文本大小
/// - Parameter font: 字体
- (CGSize)hh_textSizeInFont:(UIFont *)font;
/// 限制宽度
- (CGSize)hh_textSizeInWidth:(CGFloat)width font:(UIFont *)font;

- (CGSize)hh_textSizeIn:(CGSize)size font:(UIFont *)font;
- (CGSize)hh_textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)abreakMode align:(NSTextAlignment)alignment;

+ (CGSize)hh_textSizeIn:(CGSize)size font:(UIFont *)font string:(NSString *)string;
+ (CGSize)hh_textSizeInWidth:(CGFloat)width font:(UIFont *)font string:(NSString *)string;

+ (CGSize)hh_textSizeIn:(CGSize)size attrString:(NSAttributedString *)attrString;
+ (CGSize)hh_textSizeInWidth:(CGFloat)width attrString:(NSAttributedString *)attrString;

@end

NS_ASSUME_NONNULL_END
