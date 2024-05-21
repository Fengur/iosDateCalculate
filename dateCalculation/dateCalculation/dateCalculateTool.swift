//
//  dateCalculateTool.swift
//  dateCalculation
//
//  Created by fengur on 2024/5/21.
//

import UIKit


@objc public class dateCalculateTool: NSObject {
    /*
     ●对于当天内的消息，使用“HH:MM”格式。
     ●对于昨天内的消息，使用“昨天  HH:MM”格式。
     ●对于超过昨天但在一周内（例如今天是周六，则回溯到上周日为“一周”，共七天），使用“星期x”（x=一、二、三、四、五、六、日）
     ●对于超过一周但在当前年份内的消息，使用“月-日”格式。
     ●对于超过当前年份的消息，使用“年-月-日”格式。
     12小时和24小时制切换显示时，目前按照微信处理方式处理
     */
    @objc public static func formattedTimeStrWithTimeInterval(useTime: TimeInterval) -> String {
        // 如果时间戳小于或等于0，返回空字符串
        if useTime <= 0 {
            return ""
        }
        
        // 将时间戳转换为日期对象
        let date = Date(timeIntervalSince1970: useTime)
        
        // 异常数据，已经大于当前时间 直接显示年月日
        if useTime > Date().timeIntervalSince1970 {
            let yearMonthDayFormatter = DateFormatter();
            yearMonthDayFormatter.dateFormat = "yyyy/MM/dd"
            return yearMonthDayFormatter.string(from: date)
        }
        
        // 获取日历对象
        let calendar = Calendar.current
        
        // 获取日期的年、月、日、星期的组件
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        // 获取当前日期的年、月、日、星期的组件
        let currentComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: Date())
        
        // 如果日期在当前年份
        if components.year == currentComponents.year {
            // 如果日期是今天
            if calendar.isDateInToday(date) {
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                return timeFormatter.string(from: date)
            }
            // 如果日期是昨天
            else if calendar.isDateInYesterday(date) {
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "昨天 HH:mm"
                return timeFormatter.string(from: date)
            }
            // 如果日期在过去的一周内
            else {
                let oneWeekAgo = Date(timeIntervalSinceNow: -7*24*60*60)
                if date > oneWeekAgo {
                    let weekdayFormatter = DateFormatter()
                    weekdayFormatter.dateFormat = "EEEE"
                    let weekdayString = weekdayFormatter.string(from: date)
                    return weekdayString
                }
                // 如果日期在过去的一周之外，但在当前年份
                else {
                    let monthDayFormatter = DateFormatter()
                    monthDayFormatter.dateFormat = "M-d"
                    return monthDayFormatter.string(from: date)
                }
            }
        }
        // 如果日期不在当前年份
        else {
            let yearMonthDayFormatter = DateFormatter()
            yearMonthDayFormatter.dateFormat = "yyyy/M/d"
            return yearMonthDayFormatter.string(from: date)
        }
    }
}
