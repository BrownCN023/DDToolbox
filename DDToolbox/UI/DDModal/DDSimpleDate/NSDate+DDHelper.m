//
//  NSDate+DDHelper.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "NSDate+DDHelper.h"

@implementation NSDate (DDHelper)

+ (NSInteger)firstWeekdayInThisMotnth:(NSDate *)date{
    
    // 取得当前用户的逻辑日历(logical calendar)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设定每周的第一天从星期几开始，
    // 比如:. 如需设定从星期日开始，则value传入1 ，如需设定从星期一开始，则value传入2 ，以此类推
    [calendar setFirstWeekday:1];
    
    //将日期转换成日历组件 NSDateComponents
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comp setDay:1]; // 设置为这个月的第一天
    
    NSDate * firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    // 这个月第一天在当前日历的顺序
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的顺序
    return firstWeekday - 1;
}

+ (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date]; // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围
    
    return daysInOfMonth.length;
}

// 日历的上一个月
+ (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:date options:0];
    return newDate;
}

// 日历的上一个月
+ (NSDate *)nextMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:date options:0];
    return newDate;
}

//// 获取日历的年份
//+ (NSInteger)year:(NSDate *)date{
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [components year];
//}
//
//// 获取日历的月份
//+ (NSInteger)month:(NSDate *)date{
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [components month];
//}
//
//// 获取日历的为第几天
//+ (NSInteger)day:(NSDate *)date{
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    return [components day];
//}

- (NSInteger)year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.year;
}
- (NSInteger)month{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.month;
}
- (NSInteger)day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.day;
}

- (NSDate *)offsetByMonth:(NSInteger)offset{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = offset;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:self options:0];
    return newDate;
}


- (void)year:(NSInteger *)year month:(NSInteger *)month day:(NSInteger *)day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    *year = components.year;
    *month = components.month;
    *day = components.day;
}

@end
