//
//  NSBundle+HHTool.h
//  Pods
//
//  Created by Henry on 2020/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (HHTool)

+ (instancetype)hhResourceBundle;

+ (UIImage *)getImageForHHTool:(NSString *)name;

+ (NSString *)getToolFilePath:(NSString *)name type:(NSString *)type;

+ (void)hhResetLanguage;

+ (NSString *)hhLocalizedStringForKey:(NSString *)key;

+ (NSString *)hhLocalizedStringForKey:(NSString *)key value:(nullable NSString *)value;

+ (NSString *)getLanguage;

+ (NSInteger)HHGetLanguageType;

@end

NS_ASSUME_NONNULL_END
