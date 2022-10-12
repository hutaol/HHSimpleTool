//
//  NSDate+HHTime.m
//  Pods
//
//  Created by Henry on 2021/6/23.
//

#import "NSDate+HHTime.h"

@implementation NSDate (HHTime)

- (NSString *)toTimestamp {
    NSTimeInterval time = [self timeIntervalSince1970] * 1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (NSString *)toStringWithFormat:(NSString *)format {
    if (format || format.length == 0) {
        format = @"yyyy-MM-dd HH:mm";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString *)toString {
    return [self toStringWithFormat:nil];
}

+ (NSString *)timestamp:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSTimeInterval time = [date timeIntervalSince1970] * 1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)timestamp {
    return [self timestamp:nil];
}

+ (NSString *)string:(NSDate *)date format:(NSString *)format {
    if (!date) {
        return @"";
    }
    if (format || format.length == 0) {
        format = @"yyyy-MM-dd HH:mm";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)string:(NSDate *)date {
    return [self string:date format:nil];
}

+ (NSString *)string {
    return [self string:nil];
}

+ (NSDate *)date:(NSString *)timestamp {
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

+ (NSDate *)dateForString:(NSString *)string format:(NSString *)format {
    if (!format || format.length == 0) {
        // 根据字符串长度模糊匹配
        if (string.length == 10) {
            format = @"yyyy-MM-dd";
        } else if (string.length == 16) {
            format = @"yyyy-MM-dd HH:mm";
        } else if (string.length == 18) {
            format = @"yyyy-MM-dd HH:mm:ss";
        } else {
            format = @"yyyy-MM-dd HH:mm";
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *destDate = [dateFormatter dateFromString:format];
    return destDate;
}

+ (NSDate *)dateForString:(NSString *)string {
    return [self dateForString:string format:nil];
}

+ (NSString *)timestampForString:(NSString *)string format:(NSString *)format {
    NSDate *date = [self dateForString:string format:format];
    return [self timestamp:date];
}

+ (NSString *)timestampForString:(NSString *)string {
    return [self timestampForString:string format:nil];
}

+ (NSString *)stringForTimestamp:(NSString *)timestamp format:(NSString *)format {
    NSDate *date = [self date:timestamp];
    return [self string:date format:format];
}

+ (NSString *)stringForTimestamp:(NSString *)timestamp {
    return [self stringForTimestamp:timestamp format:nil];
}

@end
