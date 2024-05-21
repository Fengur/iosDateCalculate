//
//  FGDateCalculateTool.h
//  dateCalculation
//
//  Created by fengur on 2024/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGDateCalculateTool : NSObject

/*
 ●对于当天内的消息，使用“HH:MM”格式。
 ●对于昨天内的消息，使用“昨天  HH:MM”格式。
 ●对于超过昨天但在一周内（例如今天是周六，则回溯到上周日为“一周”，共七天），使用“星期x”（x=一、二、三、四、五、六、日）
 ●对于超过一周但在当前年份内的消息，使用“月-日”格式。
 ●对于超过当前年份的消息，使用“年-月-日”格式。
 12小时和24小时制切换显示时，目前按照微信处理方式处理
 */
+ (NSString *)formattedTimeStrWithTimeInterval:(NSTimeInterval)useTime;

@end

NS_ASSUME_NONNULL_END
