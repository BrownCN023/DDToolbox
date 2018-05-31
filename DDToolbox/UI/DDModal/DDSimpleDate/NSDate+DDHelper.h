//
//  NSDate+DDHelper.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DDHelper)

+ (NSInteger)firstWeekdayInThisMotnth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate *)nextMonth:(NSDate *)date;

//+ (NSInteger)year:(NSDate *)date;
//+ (NSInteger)month:(NSDate *)date;
//+ (NSInteger)day:(NSDate *)date;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
//根据当前日期进行月数的偏移
- (NSDate *)offsetByMonth:(NSInteger)offset;
- (void)year:(NSInteger *)year month:(NSInteger *)month day:(NSInteger *)day;

@end
