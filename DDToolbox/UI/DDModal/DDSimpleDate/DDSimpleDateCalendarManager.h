//
//  DDSimpleDateCalendarManager.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+DDHelper.h"
#import "DDMacro.h"

@interface DDSimpleDateItem : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) BOOL isToday;
@property (nonatomic,assign) BOOL isSelected;
@end

@interface DDSimpleDateSection : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,strong) NSArray<DDSimpleDateItem *> * dayItems;
@end

@interface DDSimpleDateCalendarManager : NSObject
@property (nonatomic,assign,readonly) NSInteger todayYear;
@property (nonatomic,assign,readonly) NSInteger todayMonth;
@property (nonatomic,assign,readonly) NSInteger today;
@property (nonatomic,strong,readonly) NSDate * todayDate;
@property (nonatomic,strong,readonly) NSMutableArray<DDSimpleDateSection *> * monthItems;
@property (nonatomic,assign,readonly) NSInteger currentMonthIndex;

- (instancetype)initWithMinYear:(NSUInteger)minYear maxYear:(NSUInteger)maxYear;
- (void)prepare;

@end
