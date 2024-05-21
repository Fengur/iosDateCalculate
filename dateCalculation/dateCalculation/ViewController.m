//
//  ViewController.m
//  dateCalculation
//
//  Created by fengur on 2024/5/21.
//

#import "ViewController.h"
#import "dateCalculation-Swift.h"
#import "FGDateCalculateTool.h"

@class dateCalculateTool;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    // 异常数据 现在时间的一天后
    NSTimeInterval tomorrowTime = currentTimeInterval + 60 * 60 * 24;
    // 一个小时前
    NSTimeInterval oneOurAgoTime = currentTimeInterval - 60 * 60;
    // 3个小时前
    NSTimeInterval oneHourAgoTime = currentTimeInterval - 60 * 60 * 3;
    // 昨天的消息
    NSTimeInterval yesterDayTime = currentTimeInterval - 60 * 60 * 24;
    // 一周内的消息
    NSTimeInterval inWeekTime = currentTimeInterval - 60 * 60 * 24 * 2;
    // 超过一周但在当前年份内的消息
    NSTimeInterval inYearTime = currentTimeInterval - 60 * 60 * 24 * 8;
    // 超过当前年份内的消息
    NSTimeInterval outOfYearTime = currentTimeInterval - 60 * 60 * 24 * 366;
    
    NSArray<NSNumber *> *useTimes = @[
        @(tomorrowTime),
        @(oneOurAgoTime),
        @(oneHourAgoTime),
        @(yesterDayTime),
        @(inWeekTime),
        @(inYearTime),
        @(outOfYearTime)
    ];
    
    // OC 示例
    for (NSNumber *useTimeNumber in useTimes) {
        NSTimeInterval useTime = [useTimeNumber doubleValue];
        NSString *formattedDate = [FGDateCalculateTool formattedTimeStrWithTimeInterval:useTime];
        NSLog(@"OC Formatted Date: %@", formattedDate);
    }
        
    NSLog(@"\n\n\n");
    
    for (NSNumber *useTimeNumber in useTimes) {
        NSTimeInterval useTime = [useTimeNumber doubleValue];
        NSString *formattedDate = [dateCalculateTool formattedTimeStrWithTimeIntervalWithUseTime:useTime];
        NSLog(@"Swift Formatted Date: %@", formattedDate);
    }
}

@end
