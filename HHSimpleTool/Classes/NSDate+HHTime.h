//
//  NSDate+HHTime.h
//  Pods
//
//  Created by Henry on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HHTime)

/// 转时间戳（13位 毫秒）
- (NSString *)hh_toTimestamp;

/// 转字符串
/// @param format  默认：yyyy-MM-dd HH:mm
- (NSString *)hh_toStringWithFormat:(nullable NSString *)format;
- (NSString *)hh_toString;

/// 时间转时间戳（毫秒）
/// @param date date=nil为当前时间
/// @return 时间戳 毫秒13位
+ (NSString *)hh_timestamp:(nullable NSDate *)date;
+ (NSString *)hh_timestamp;

/// 时间转字符串
/// @param date  date=nil为当前时间
/// @param format 默认：yyyy-MM-dd HH:mm
+ (NSString *)hh_string:(nullable NSDate *)date format:(nullable NSString *)format;
+ (NSString *)hh_string:(nullable NSDate *)date;
+ (NSString *)hh_string;

/// 时间戳转NSDate
/// @param timestamp 时间戳
+ (nullable NSDate *)hh_date:(nullable NSString *)timestamp;

/// 字符串转NSDate
/// @param string 字符串
/// @param format 默认：yyyy-MM-dd HH:mm
+ (NSDate *)hh_dateForString:(nullable NSString *)string format:(nullable NSString *)format;
+ (NSDate *)hh_dateForString:(nullable NSString *)string;

/// 字符串转时间戳(毫秒)
+ (NSString *)hh_timestampForString:(NSString *)string format:(nullable NSString *)format;
+ (NSString *)hh_timestampForString:(NSString *)string;

/// 时间戳转字符串(毫秒)
+ (NSString *)hh_stringForTimestamp:(NSString *)timestamp format:(nullable NSString *)format;
+ (NSString *)hh_stringForTimestamp:(NSString *)timestamp;

@end

NS_ASSUME_NONNULL_END
