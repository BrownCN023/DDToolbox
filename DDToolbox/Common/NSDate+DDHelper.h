//
//  NSDate+DDHelper.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DDHelper)

//日期月的第一天是周几
+ (NSInteger)firstWeekdayInThisMotnth:(NSDate *)date;
//日期月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

//根据当前日期进行年的偏移
- (NSDate *)offsetByYear:(NSInteger)offset;
//根据当前日期进行月的偏移
- (NSDate *)offsetByMonth:(NSInteger)offset;
//根据当前日期进行日的偏移
- (NSDate *)offsetByDay:(NSInteger)offset;
//提取年月日
- (void)year:(NSInteger *)year month:(NSInteger *)month day:(NSInteger *)day;

- (NSDate *)lastYear;  //上一年
- (NSDate *)nextYear;  //下一年
- (NSDate *)lastMonth; //上个月
- (NSDate *)nextMonth; //下个月
- (NSDate *)lastDay;   //前一天
- (NSDate *)nextDay;   //后一天

@property (nonatomic,assign,readonly) NSUInteger year;
@property (nonatomic,assign,readonly) NSUInteger month;
@property (nonatomic,assign,readonly) NSUInteger day;

@end
