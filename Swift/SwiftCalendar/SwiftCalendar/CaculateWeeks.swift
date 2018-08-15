//
//  CaculateWeeks.swift
//  Calendar
//
//  Created by 童世超 on 2018/8/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

import UIKit

class CaculateWeeks: NSObject {
    //当前日期在数据源中的位置
    static var currentWeekPostition: NSInteger = 0
    //计算闰年
    class func isLearYear(_ year: NSInteger) -> Bool {
        return (( year % 100 != 0 ) ? (year % 4 == 0) : (year % 400 == 0)) ? true : false
    }
    
    //计算周
    class func convertDateToFirstWeekDay(date: Date) -> NSInteger {
        var calendar = NSCalendar.current
        //设置自然周
        calendar.firstWeekday = 2 //1.Mon. 2.Thes. 3.Wed. 4Thur. 5.Fri. 6.Sat. 7.Sun.
        let component = calendar.dateComponents([Calendar.Component.year, Calendar.Component.weekOfMonth, Calendar.Component.day], from: date)
        let firstDayOfMonthDate = calendar.date(from: component)
        let firstWeekday = calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: firstDayOfMonthDate!)
        return firstWeekday! - 1
    }
    
    //将分割的年月日整合成日期
    class func dateFrom(_ year:NSInteger, _ month:NSInteger, _ day:NSInteger) -> Date? {
        var component = DateComponents()
        component.year = year
        component.month = month
        component.day = day
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.date(from: component)
    }

    class func invokeYearDayMonth(date: Date, dateStyle: DateFormatter.Style = .short, dateFormat: String = "yyyy-MM-dd", timeStyle:DateFormatter.Style = .none) -> String {
        
        let format = DateFormatter()
        format.dateStyle = dateStyle
        format.timeStyle = timeStyle
        format.locale = Locale(identifier: "zh_CN")
        format.dateFormat = dateFormat
        return format.string(from: date)
        
    }
    
    //计算一年中的周，并整合数据
    class func weeks(of year:NSInteger) -> [String] {
        let learYear = isLearYear(year)
        let dayCount = learYear ? 366 : 365
        let dayOfMonthCountArray = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var dataSource = [String]()  //周数据源
        var monthArray = [String]()  //连续周
        
        //效率貌似有点低
//        let test = dayOfMonthCountArray.enumerated().map { (arg) -> Int in
//            return dayOfMonthCountArray[0..<(arg.offset + 1)].reduce(0) {$0 + $1}
//        }
        
        var sum = 0
        let totalDayCountArray = dayOfMonthCountArray.map { (num) -> Int in
            sum += num
            if (learYear && num == 28) {
                sum += 1;
            }
            return sum
        }
        
        //当前时间
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "MM月dd日"
        let currentDateString = formatter.string(from: currentDate)
        
        //遍历 /从年初开始算起
        for day in 0..<dayCount {
            
            var month = 0  //月份
            var dayOfCurrenMonth = 0   //当月的第几天
            
            if day <= 31 {  //第一个月
                dayOfCurrenMonth = day
            } else { //后续11个月
                for index in 0..<12 {
                    if day <= totalDayCountArray[index] {
                        month = index
                        dayOfCurrenMonth = day - totalDayCountArray[index - 1];
                        break
                    }
                }
            }
            
            //月和日索引都是从0开始，要加1
            let date = dateFrom(year, month + 1, dayOfCurrenMonth + 1) ?? Date()
            let weekIdx = convertDateToFirstWeekDay(date: date)
            let currentString = invokeYearDayMonth(date: date, dateFormat: "MM月dd日")
            monthArray.append(currentString)
            
            //如果是周日的索引
            if weekIdx == 6 {
                
                if let idx = monthArray.index(of: currentDateString) {
                    currentWeekPostition = idx + dataSource.count;
                }
                dataSource.append("\(monthArray.first ?? "")-\(monthArray.last ?? "")")
                monthArray.removeAll()
            }
        }
        
        if monthArray.count != 0 {
            if let idx = monthArray.index(of: currentDateString) {
                currentWeekPostition = idx + dataSource.count;
            }
            dataSource.append("\(monthArray.first ?? "")-\(monthArray.last ?? "")")
            monthArray.removeAll()
        }
        return dataSource
    }
}
