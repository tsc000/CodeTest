//
//  CaculateWeek.m
//  Driver
//
//  Created by 童世超 on 2018/8/14.
//  Copyright © 2018年 Aerozhonghuan. All rights reserved.
//

#import "CaculateWeek.h"

@implementation CaculateWeek

//判断闰年
+ (BOOL)isLeapyear:(NSInteger)year {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return true;
    }
    return false;
}

//根据date获取当月周几
+ (NSInteger)convertDateToFirstWeekDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//1.Mon. 2.Thes. 3.Wed. 4Thur. 5.Fri. 6.Sat. 7.Sun.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1; //改为0-6方便计算
}

+ (NSArray *)weekData:(NSInteger)year {
    bool learYear = [self isLeapyear:year];
    
    NSInteger dayCount = learYear ? 366 : 365;
    NSInteger index = 0; //
    NSInteger dayCountArray[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    NSInteger totalDayCountArray[12];
    NSInteger sum = 0;
    NSMutableArray *dataSource = [@[] mutableCopy];
    
    for (NSInteger i = 0; i < 12; i ++) {
        sum += dayCountArray[i];
        if (learYear && i == 1) {
            sum += 1;
        }
        totalDayCountArray[i] = sum;
    }
    
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *currentString = [formatter stringFromDate:currentDate];
    
    NSMutableArray *monthArray = [@[] mutableCopy];
    //从年初开始算起
    for (NSInteger i = 0; i < dayCount; i ++) {
        
        NSInteger pos = 0; //pos 代表月分
        NSInteger currentDay = 0; //代表当月的第几天
        
        if (i <= 31) {
            currentDay = i;
        }  else {
            
            //计算当前的天数在本年中的位置，几月几号
            for (NSInteger j = 0; j < 12; j ++) {
                
                if (i <= totalDayCountArray[j]) {
                    pos = j;
                    currentDay = i - totalDayCountArray[j - 1];
                    break;
                }
                
            }
        }
        
        NSDate *date = [self setYear:year month:pos + 1 day:currentDay + 1];
        NSInteger idx = [self convertDateToFirstWeekDay:date]; //周几
        NSLog(@"%ld", idx);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterFullStyle];
        [formatter setDateFormat:@"MM月dd日"];
        NSString *string = [formatter stringFromDate:date];
        if (idx < 6) {
            [monthArray addObject:string];
        } else {
            [monthArray addObject:string];
            NSInteger tempIdx = [monthArray indexOfObject:currentString];
            NSLog(@"%ld", tempIdx);
            if (tempIdx < 7) {
                weekIdx = tempIdx + dataSource.count - 1;
            }
            [dataSource addObject:[NSString stringWithFormat:@"%@-%@", monthArray.firstObject, monthArray.lastObject]];
            [monthArray removeAllObjects];
        }
        
    }
    
    if (monthArray.count != 0) {
        NSInteger tempIdx = [monthArray indexOfObject:currentString];
        if (tempIdx < 7) {
            weekIdx = tempIdx + dataSource.count - 1;
        }
        
        [dataSource addObject:[NSString stringWithFormat:@"%@-%@", monthArray.firstObject, monthArray.lastObject]];
    }
    
    return dataSource;
    //    NSLog(@"-----------------------");
    //    for (NSString *s in dataSource) {
    //        NSLog(@"%@", s);
    //    }
}

//设置日期
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth: month];
    [comp setDay: day];
    [comp setYear: year];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [myCal dateFromComponents:comp];
    NSLog(@"%@", date);
    
    return date;
}


@end
