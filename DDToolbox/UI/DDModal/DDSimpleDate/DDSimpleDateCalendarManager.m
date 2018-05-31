//
//  DDSimpleDateCalendarManager.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleDateCalendarManager.h"


@implementation DDSimpleDateItem

@end

@implementation DDSimpleDateSection

@end

@interface DDSimpleDateCalendarManager()

@property (nonatomic,assign) NSInteger todayYear;
@property (nonatomic,assign) NSInteger todayMonth;
@property (nonatomic,assign) NSInteger today;
@property (nonatomic,strong) NSDate * todayDate;
@property (nonatomic,strong) NSMutableArray<DDSimpleDateSection *> * monthItems;

@property (nonatomic,assign) NSInteger minYear;
@property (nonatomic,assign) NSInteger maxYear;

@end

@implementation DDSimpleDateCalendarManager

- (instancetype)initWithMinYear:(NSUInteger)minYear maxYear:(NSUInteger)maxYear{
    self = [super init];
    if (self) {
        [self initData];
        self.minYear = minYear;
        self.maxYear = maxYear;
        if(minYear > maxYear){
            NSLog(@"error: minYear不能大于maxYear");
        }
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
        self.minYear = 1970;
        self.maxYear = 2100;
    }
    return self;
}

- (void)initData{
    self.todayDate = [NSDate date];
    self.monthItems = [NSMutableArray new];
}

- (void)prepare{
    [self monthEnlarge];
}

- (void)monthEnlarge{
    NSInteger todayYear = 0;
    NSInteger todayMonth = 0;
    NSInteger today = 0;
    [self.todayDate year:&todayYear month:&todayMonth day:&today];
    
    self.todayYear = todayYear;
    self.todayMonth = todayMonth;
    self.today = today;
    
    NSInteger lastOffsetSize = (todayYear-self.minYear)*12+todayMonth;
    NSInteger nextOffsetSize = (self.maxYear-todayYear)*12+12-(todayMonth-1);
    _currentMonthIndex = lastOffsetSize-2;
    
    NSMutableArray * lastMonthItems = [NSMutableArray new];
    NSMutableArray * nextMonthItems = [NSMutableArray new];
    NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
    
    //last [0:today,1yesterday...]
    for(NSInteger i=0,index = 0;i<lastOffsetSize;i++,index ++){
        NSDate * lastOffsetMonth = [self.todayDate offsetByMonth:-i];
        DDSimpleDateSection * section = [self dayItemsInMonth:lastOffsetMonth todayYear:todayYear todayMonth:todayMonth today:today];
        if(i == 0){
            [lastMonthItems addObject:section];
        }else{
            [lastMonthItems insertObject:section atIndex:0];
        }
        [indexSet addIndex:index];
    }
    
    //next [1:tomorrow,2...]
    for(NSInteger i=1;i<nextOffsetSize;i++){
        NSDate * nextOffsetMonth = [self.todayDate offsetByMonth:i];
        DDSimpleDateSection * section = [self dayItemsInMonth:nextOffsetMonth todayYear:todayYear todayMonth:todayMonth today:today];
        [nextMonthItems addObject:section];
    }
    
    [self.monthItems insertObjects:lastMonthItems atIndexes:indexSet];
    [self.monthItems addObjectsFromArray:nextMonthItems];
}

- (DDSimpleDateSection *)dayItemsInMonth:(NSDate *)date todayYear:(NSInteger)todayYear todayMonth:(NSInteger)todayMonth today:(NSInteger)today{
    
    DDSimpleDateSection * section = [DDSimpleDateSection new];
    NSMutableArray * dayItems = [NSMutableArray new];
    NSInteger firstWeekday = [NSDate firstWeekdayInThisMotnth:date];
    NSInteger totalDays = [NSDate totaldaysInMonth:date];
    NSInteger totalItem = firstWeekday + totalDays;
    
    NSInteger year = 0;
    NSInteger month = 0;
    NSInteger day = 0;
    [date year:&year month:&month day:&day];
    
    section.year = year;
    section.month = month;
    
    for(NSInteger i=0;i<totalItem;i++){
        DDSimpleDateItem * item = [DDSimpleDateItem new];
        if(i < firstWeekday){
            item.year = -1;
            item.month = -1;
            item.day = -1;
        }else{
            item.year = year;
            item.month = month;
            item.day = i-firstWeekday+1;
            if(year == todayYear && month == todayMonth && today == item.day){
                item.isToday = YES;
            }
        }
        [dayItems addObject:item];
    }
    section.dayItems = dayItems;
    return section;
}

@end
