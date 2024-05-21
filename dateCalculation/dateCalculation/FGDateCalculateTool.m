//
//  FGDateCalculateTool.m
//  dateCalculation
//
//  Created by fengur on 2024/5/21.
//

#import "FGDateCalculateTool.h"

@implementation FGDateCalculateTool

+ (NSString *)formattedTimeStrWithTimeInterval:(NSTimeInterval)useTime {
    if(useTime <= 0) {
        return @"";
    }
    // 将时间戳转换为日期对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:useTime];
    
    // 异常数据，已经大于当前时间 直接显示年月日
    if (useTime > [[NSDate date] timeIntervalSince1970]) {
        NSDateFormatter *yearMonthDayFormatter = [[NSDateFormatter alloc] init];
        [yearMonthDayFormatter setDateFormat:@"yyyy/MM/dd"];
        return [yearMonthDayFormatter stringFromDate:date];
    }
    
    // 获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取日期的年、月、日、星期的组件
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    
    // 获取当前日期的年、月、日、星期的组件
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    // 如果日期在当前年份
    if (components.year == currentComponents.year) {
        // 如果日期是今天
        if ([calendar isDateInToday:date]) {
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
            [timeFormatter setDateFormat:@"HH:mm"];
            return [timeFormatter stringFromDate:date];
        }
        // 如果日期是昨天
        else if ([calendar isDateInYesterday:date]) {
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
            [timeFormatter setDateFormat:@"昨天 HH:mm"];
            return [timeFormatter stringFromDate:date];
        }
        // 如果日期在过去的一周内
        else {
            NSDate *oneWeekAgo = [[NSDate date] dateByAddingTimeInterval:-7*24*60*60];
            if ([date compare:oneWeekAgo] == NSOrderedDescending) {
                NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
                [weekdayFormatter setDateFormat:@"EEEE"];
                NSString *weekdayString = [weekdayFormatter stringFromDate:date];
                return [NSString stringWithFormat:@"%@", weekdayString];
            }
            // 如果日期在过去的一周之外，但在当前年份
            else {
                NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
                [monthDayFormatter setDateFormat:@"M-d"];
                return [monthDayFormatter stringFromDate:date];
            }
        }
    }
    // 如果日期不在当前年份
    else {
        NSDateFormatter *yearMonthDayFormatter = [[NSDateFormatter alloc] init];
        [yearMonthDayFormatter setDateFormat:@"yyyy/MM/dd"];
        return [yearMonthDayFormatter stringFromDate:date];
    }
}

@end
