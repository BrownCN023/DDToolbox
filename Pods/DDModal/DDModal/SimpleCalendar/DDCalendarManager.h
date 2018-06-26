//
//  DDCalendarManager.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+DDModal.h"

@interface DDDateItem : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign,getter=isToday) BOOL today;
@property (nonatomic,assign,getter=isSelected) BOOL selected;
@property (nonatomic,assign,getter=isDisable) BOOL disable;
@end

@interface DDDateSection : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,strong) NSArray<DDDateItem *> * dayItems;
@end

@interface DDCalendarManager : NSObject

@property (nonatomic,assign,readonly) NSInteger todayYear;
@property (nonatomic,assign,readonly) NSInteger todayMonth;
@property (nonatomic,assign,readonly) NSInteger todayDay;
@property (nonatomic,strong,readonly) NSDate * todayDate;

@property (nonatomic,strong,readonly) NSMutableArray<DDDateSection *> * monthItems;
@property (nonatomic,assign,readonly) NSInteger currentMonthIndex;
- (instancetype)initWithMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;
- (instancetype)initWithMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate disableLastDate:(NSDate *)disableMinDate disableNextDate:(NSDate *)disableMaxDate;
- (void)prepare;

@end
