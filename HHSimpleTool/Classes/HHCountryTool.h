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

@interface HHCountryTool : NSObject

+ (instancetype)sharedInstance;

+ (void)attempDealloc;

/// 获取所有国家
/// @param compelete 回调所有国家
- (void)getCountryCompelete:(void(^)(NSArray<HHCountry *> *dataArray))compelete;

/// 获取所有国家 排序Section
/// @param showCurrent 是否显示当前国家在第一个section
/// @param compelete 回调
- (void)getCountrySection:(BOOL)showCurrent compelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete;

/// 获取所有国家 排序Section
/// showCurrent = NO 不显示当前国家在第一个section
/// @param compelete 回调
- (void)getCountrySectionCompelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete;

/// 获取本地国家
/// 前提是获取了所有国家，执行了`getCountryCompelete`
- (HHCountry *)getlocaleCountry;

/// 根据code获取国家
/// 前提是获取了所有国家，执行了`getCountryCompelete`
/// @param code 代码
- (HHCountry *)findCountry:(NSString *)code;

/// 获取本地地区
/// @param compelete 回调国家
- (void)getlocaleCountryCompelete:(void(^)(HHCountry *country))compelete;

/// 根据code获取国家
/// @param code 代码
/// @param compelete 回调国家
- (void)findCountry:(NSString *)code Compelete:(void(^)(HHCountry *country))compelete;

@end

NS_ASSUME_NONNULL_END
