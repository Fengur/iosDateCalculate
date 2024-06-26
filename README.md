# FGDateCalculateTool

FGDateCalculateTool是一个用于格式化时间戳的工具类，根据一定的规则将时间戳转换为特定的日期格式。

## 使用方法

1. 将`FGDateCalculateTool.h`和`FGDateCalculateTool.m`文件添加到您的Objective-C项目中。

2. 在需要使用的地方导入头文件： #import "FGDateCalculateTool.h"

3. 调用formattedTimeStrWithTimeInterval:方法来格式化时间戳：

```
NSTimeInterval useTime = 1621576800; // 示例时间戳
NSString *formattedTimeStr = [FGDateCalculateTool formattedTimeStrWithTimeInterval:useTime];
NSLog(@"Formatted Time: %@", formattedTimeStr);
```
4. 工程内也提供了swift方法可供使用 并有示例
## 规则说明
FGDateCalculateTool根据以下规则对时间戳进行格式化：

 - 异常数据，已经大于当前时间的时间戳直接显示年月日。
 - 如果时间戳在当前年份内：
    - 如果时间戳是今天，则显示小时和分钟（HH:mm）。
    - 如果时间戳是昨天，则显示"昨天"和小时分钟（昨天 HH:mm）。
    - 如果时间戳在过去的一周内，则显示星期几（例如：星期一、星期二）。
    - 如果时间戳在过去的一周之外但在当前年份内，则显示月份和日期（M-d）。
- 如果时间戳不在当前年份内，则显示完整的年月日（yyyy/MM/dd）。

## 示例
```
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
```
Logcat:
```
OC Formatted Date: 2024/05/22
OC Formatted Date: 16:22
OC Formatted Date: 14:22
OC Formatted Date: 昨天 17:22
OC Formatted Date: Sunday
OC Formatted Date: 5-13
OC Formatted Date: 2023/05/21

Swift Formatted Date: 2024/05/22
Swift Formatted Date: 16:22
Swift Formatted Date: 14:22
Swift Formatted Date: 昨天 17:22
Swift Formatted Date: Sunday
Swift Formatted Date: 5-13
Swift Formatted Date: 2023/5/21
```
## MIT