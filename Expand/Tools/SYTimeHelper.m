//
//  SYTimeHelper.m
//  JMTools
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "SYTimeHelper.h"

@implementation SYTimeHelper

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDateFormatter *)YYYY_MM_DD_dot {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy.MM.dd"];
    });
    return df;
}

+ (NSDateFormatter *)MM_DD_HH_MM_Chinese {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: Localized(@"MM月dd日 HH:mm")];
    });
    return df;
}

+ (NSDateFormatter *)YYYY_MM_DD_HH_MM_SS {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    });
    return df;
}


+ (NSDateFormatter *)YYYY_MM_DD_HH_MM {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy-MM-dd HH:mm"];
    });
    return df;
}

+ (NSDateFormatter *)MM_DD_HH_MM {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"MM-dd HH:mm"];
    });
    return df;
}

+ (NSDateFormatter *)HH_MM_SS_MM_DDYYYY {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"HH:mm:ss MM-dd yyyy"];
    });
    return df;
}

+ (NSDateFormatter *)YYYY {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy"];
    });
    return df;
}

+ (NSDateFormatter *)YYYY_MM_DD {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy-MM-dd"];
    });
    return df;
}

+ (NSDateFormatter *)HH_MM_SS {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"HH:mm:ss"];
    });
    return df;
}
+ (NSDateFormatter *)HH_MM {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"HH:mm"];
    });
    return df;
}

+ (NSDateFormatter *)hh12_MM {
    static NSDateFormatter *df;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        df.AMSymbol = Localized(@"上午");
        df.PMSymbol = Localized(@"下午");
        [df setDateFormat: @"a hh:mm"];
    });
    return df;
}

+ (NSInteger)timeIntervalFrom:(NSString *)startTimeStr to:(NSString *)endTimeStr{

    // 时间1
    NSDate *date1 = [SYTimeHelper dateFromString:startTimeStr];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:date1];
    NSDate *localDate1 = [date1 dateByAddingTimeInterval:interval1];
    
    // 时间2
    NSDate *date2 = [SYTimeHelper dateFromString:endTimeStr];
    NSTimeZone *zone2 = [NSTimeZone systemTimeZone];
    NSInteger interval2 = [zone2 secondsFromGMTForDate:date2];
    NSDate *localDate2 = [date2 dateByAddingTimeInterval:interval2];
    
    // 时间2与时间1之间的时间差（秒）
    double intervalTime = [localDate2 timeIntervalSinceReferenceDate] - [localDate1 timeIntervalSinceReferenceDate];
    
    NSInteger seconds = (NSInteger)intervalTime % 60;
//    NSInteger minutes = ((NSInteger)intervalTime / 60) % 60;
//    NSInteger hours = (intervalTime / 3600);
//    NSInteger days = intervalTime/60/60/24;
//    NSInteger month = intervalTime/60/60/24/12;
//    NSInteger years = intervalTime/60/60/24/365;
    return seconds;
}

+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

+ (NSString *)niceDate:(NSDate *)date {
    
    if (date == nil) {
        return @"";
    }
    
    NSTimeInterval ti3 = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
    if (ti3 < 60 ) {
        return Localized(@"刚刚");
    }
    if (ti3 < 60 * 60) {
        return [NSString stringWithFormat:Localized(@"%d 分钟前"), (int)(ti3 / 60)];
    }
    if (ti3 < 60 * 60 * 24) {
        return [NSString stringWithFormat:Localized(@"%d 小时前"), (int)(ti3 / 3600)];
    }
    
    if (ti3 < 60 * 60 * 24 * 7) {
        return [NSString stringWithFormat:Localized(@"%d 天前"), (int)(ti3 / 25200)];
    }
    
    return [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
}

//+ (NSString *)niceDate:(NSDate *)date {
//    
//    if (Object_is_Null(date)) {
//        return @"";
//    }
//    
//    NSTimeInterval ti3 = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
//    if (ti3 < 60 ) {
//        return @"刚刚";
//    }
//    if (ti3 < 60 * 60) {
//        return [NSString stringWithFormat:@"%d 分钟前", (int)(ti3 / 60)];
//    }
//    if (ti3 < 60 * 60 * 24) {
//        return [NSString stringWithFormat:@"%d 小时前", (int)(ti3 / 3600)];
//    }
//    
//    if (ti3 < 60 * 60 * 24 * 7) {
//        return [NSString stringWithFormat:@"%d 天前", (int)(ti3 / 25200)];
//    }
//    
//    return [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
//}

+ (NSString *)niceDateFromChatTimestarmp:(NSString *)str {
    
    if (str.length == 0) {
        return @"";
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
    
    NSString *someday = [[SYTimeHelper MM_DD_HH_MM] stringFromDate:date];
    NSString *today = [[SYTimeHelper MM_DD_HH_MM] stringFromDate:[NSDate date]];
    
    NSString *dd1 = [today substringWithRange:NSMakeRange(0, 5)];
    NSString *dd2 = [someday substringWithRange:NSMakeRange(0, 5)];
    
    if ([dd1 isEqualToString:dd2]) {
        //  同一天
        return [[SYTimeHelper hh12_MM] stringFromDate:date];
    }else{
        return someday;
    }
    
    return [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
}

+ (NSString *)niceDateFrom_MM_DD_HH_MM_Chinese:(NSDate *)date {
    return [[SYTimeHelper MM_DD_HH_MM_Chinese] stringFromDate:date];
}

+ (NSString *)niceDateFrom_HH_mm_ss:(NSDate *)date {
    return [[SYTimeHelper HH_MM_SS] stringFromDate:date];
}

+ (NSString *)niceDateFrom_HH_mm:(NSDate *)date {
    return [[SYTimeHelper HH_MM] stringFromDate:date];
}

+ (NSString *)niceDateFrom_12_HH_mm:(NSDate *)date {
    return [[SYTimeHelper hh12_MM] stringFromDate:date];
}

+ (NSString *)niceDateFrom_YYYY_MM_DD:(NSDate *)date {
    return [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
}

+ (NSString *)niceDateFrom_YYYY_MM_DD_HH_mm_ss:(NSDate *)date {
    return [[SYTimeHelper YYYY_MM_DD_HH_MM_SS] stringFromDate:date];
}
+ (NSString *)niceDateFrom_YYYY_MM_DD_HH_mm:(NSDate *)date {
    return [[SYTimeHelper YYYY_MM_DD_HH_MM] stringFromDate:date];
}

+ (NSString *)niceDateFrom_HH_MM_SS_MM_DDYYYY:(NSDate *)date {
    return [[SYTimeHelper HH_MM_SS_MM_DDYYYY] stringFromDate:date];
}

+ (NSString *)niceDateFrom_MM_DD_HH_MM:(NSDate *)date {
    return [[SYTimeHelper MM_DD_HH_MM] stringFromDate:date];
}

+ (NSString *)niceDateFrom_YYYY_MM_DD_dot:(NSDate *)date {
    return [[SYTimeHelper YYYY_MM_DD_dot] stringFromDate:date];
}

+ (BOOL)isAfterOrToday:(NSDate *)date {
    NSString *today = [[SYTimeHelper YYYY_MM_DD] stringFromDate:[NSDate date]];
    NSString *theday = [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
    NSDate *chooseDate = [[SYTimeHelper YYYY_MM_DD] dateFromString:theday];
    NSDate *cToday = [[SYTimeHelper YYYY_MM_DD] dateFromString:today];
    NSComparisonResult result = [chooseDate compare:cToday];
    if (result == NSOrderedAscending) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isToday:(NSDate *)date {
    NSString *today = [[SYTimeHelper YYYY_MM_DD] stringFromDate:[NSDate date]];
    NSString *theday = [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
    return [today isEqualToString:theday];
}

+ (BOOL)isYesterday:(NSDate *)date {
    NSTimeInterval oneday = 24 * 60 * 60;
    NSString *yesterday = [[SYTimeHelper YYYY_MM_DD] stringFromDate:[[NSDate date] dateByAddingTimeInterval:-oneday]];
    NSString *theday = [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
    return [yesterday isEqualToString:theday];
}

+ (BOOL)isThisYear:(NSDate *)date {
    NSString *thisYear = [[SYTimeHelper YYYY] stringFromDate:[NSDate date]];
    NSString *theYear = [[SYTimeHelper YYYY] stringFromDate:date];
    return [thisYear isEqualToString:theYear];
}

+ (NSString *)niceDateFromChatRecord:(NSDate *)date { //消息列表里的时间显示
    NSString *someday = [[SYTimeHelper MM_DD_HH_MM] stringFromDate:date];
    NSString *today = [[SYTimeHelper MM_DD_HH_MM] stringFromDate:[NSDate date]];
    
    NSString *dd1 = [today substringWithRange:NSMakeRange(0, 5)];
    NSString *dd2 = [someday substringWithRange:NSMakeRange(0, 5)];
    
    if ([dd1 isEqualToString:dd2]) {
        //  同一天
        return [[SYTimeHelper hh12_MM] stringFromDate:date];
    }
    else if ([SYTimeHelper isYesterday:date]) {
        return Localized(@"昨天");
    }
    else
    {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
     
        
        if ([self isThisYear:date]) {
               [format setDateFormat:@"M/d"];
        }else{
            [format setDateFormat:@"YY/M/d"];
        }
        return [format stringFromDate:date];
    }
    
    return [[SYTimeHelper YYYY_MM_DD] stringFromDate:date];
}

@end
