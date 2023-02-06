//
//  NSDate+HHTime.m
//  Pods
//
//  Created by Henry on 2021/6/23.
//

#import "NSDate+HHTime.h"

@implementation NSDate (HHTime)

- (NSString *)hh_toTimestamp {
    NSTimeInterval time = [self timeIntervalSince1970] * 1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (NSString *)hh_toStringWithFormat:(NSString *)format {
    if (format.length == 0) {
        format = @"yyyy-MM-dd HH:mm";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString *)hh_toString {
    return [self hh_toStringWithFormat:nil];
}

+ (NSString *)hh_timestamp:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSTimeInterval time = [date timeIntervalSince1970] * 1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)hh_timestamp {
    return [self hh_timestamp:nil];
}

+ (NSString *)hh_string:(NSDate *)date format:(NSString *)format {
    if (!date) {
        return @"";
    }
    if (format.length == 0) {
        format = @"yyyy-MM-dd HH:mm";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)hh_string:(NSDate *)date {
    return [self hh_string:date format:nil];
}

+ (NSString *)hh_string {
    return [self hh_string:nil];
}

+ (NSDate *)hh_date:(NSString *)timestamp {
    if (!timestamp || timestamp.length == 0) {
        return nil;
    }
    long long tt = [timestamp longLongValue];
    if (timestamp.length == 13) {
        tt = tt / 1000;
    }
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:tt];
    return timeDate;
}

+ (NSDate *)hh_dateForString:(NSString *)string format:(NSString *)format {
    if (!format || format.length == 0) {
        // 根据字符串长度模糊匹配
        if (string.length == 10) {
            format = @"yyyy-MM-dd";
        } else if (string.length == 16) {
            format = @"yyyy-MM-dd HH:mm";
        } else if (string.length == 19) {
            format = @"yyyy-MM-dd HH:mm:ss";
        } else {
            format = @"yyyy-MM-dd HH:mm";
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *destDate = [dateFormatter dateFromString:string];
    return destDate;
}

+ (NSDate *)hh_dateForString:(NSString *)string {
    return [self hh_dateForString:string format:nil];
}

+ (NSString *)hh_timestampForString:(NSString *)string format:(NSString *)format {
    NSDate *date = [self hh_dateForString:string format:format];
    return [self hh_timestamp:date];
}

+ (NSString *)hh_timestampForString:(NSString *)string {
    return [self hh_timestampForString:string format:nil];
}

+ (NSString *)hh_stringForTimestamp:(NSString *)timestamp format:(NSString *)format {
    NSDate *date = [self hh_date:timestamp];
    return [self hh_string:date format:format];
}

+ (NSString *)hh_stringForTimestamp:(NSString *)timestamp {
    return [self hh_stringForTimestamp:timestamp format:nil];
}

@end
