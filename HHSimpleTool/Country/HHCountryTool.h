//
//  HHCountryTool.h
//  Pods
//
//  Created by Henry on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHCountry : NSObject

@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *countryName;
@property (nonatomic, copy) NSString *countryPinyin;
@property (nonatomic, copy) NSString *phoneCode;

- (instancetype)initWithName:(NSString *)name code:(NSString *)code phoneCode:(NSString *)phoneCode pinyin:(NSString *)pinyin;

@end

typedef NSString *HHLang NS_TYPED_ENUM;

FOUNDATION_EXPORT HHLang const HHLangEN;   // 英语
FOUNDATION_EXPORT HHLang const HHLangZHCN; // 简体中文

typedef void(^HHCountryCompelete)(HHCountry *country);
typedef void(^HHCountryArrayCompelete)(NSArray<HHCountry *> *dataArray);
typedef void(^HHCountrySectionCompelete)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray);

/// 国家列表 （只支持中英文）
@interface HHCountryTool : NSObject

/// 语言
@property (nonatomic, readonly) HHLang lang;

@property (nonatomic, strong, readonly) NSArray<HHCountry *> *dataArray;

/// 单例
+ (instancetype)sharedInstance;
/// 销毁单例
+ (void)attempDealloc;

/// 获取所有国家
/// @param lang 语言 默认：HHLangEN
/// @param compelete 回调所有国家
- (void)getCountryWithLang:(HHLang)lang compelete:(nullable HHCountryArrayCompelete)compelete;
- (void)getCountryCompelete:(nullable HHCountryArrayCompelete)compelete;

/// 获取所有国家 排序Section
/// @param lang 语言 默认：HHLangEN
/// @param compelete 回调
- (void)getCountrySectionWithLang:(HHLang)lang compelete:(nullable HHCountrySectionCompelete)compelete;
- (void)getCountrySectionCompelete:(nullable HHCountrySectionCompelete)compelete;

/// 获取本地国家
/// 前提是获取了所有国家，执行了`getCountryCompelete`
- (HHCountry *)getlocaleCountry;

/// 根据code获取国家
/// 前提是获取了所有国家，执行了`getCountryCompelete`
/// @param code 代码
- (HHCountry *)findCountry:(NSString *)code;

/// 获取本地国家
/// @param compelete 回调国家
- (void)getlocaleCountryCompelete:(HHCountryCompelete)compelete;

/// 根据code获取国家
/// @param code 代码
/// @param compelete 回调国家
- (void)findCountry:(NSString *)code compelete:(HHCountryCompelete)compelete;

@end

NS_ASSUME_NONNULL_END
