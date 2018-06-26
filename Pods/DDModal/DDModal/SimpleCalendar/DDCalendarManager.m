//
//  DDCalendarManager.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDCalendarManager.h"

@implementation DDDateItem

@end

@implementation DDDateSection

@end


@interface DDCalendarManager()

@property (nonatomic,assign) NSInteger minYear;
@property (nonatomic,assign) NSInteger minMonth;
@property (nonatomic,assign) NSInteger minDay;
@property (nonatomic,assign) NSInteger maxYear;
@property (nonatomic,assign) NSInteger maxMonth;
@property (nonatomic,assign) NSInteger maxDay;

@property (nonatomic,assign) NSInteger disableMinYear;
@property (nonatomic,assign) NSInteger disableMinMonth;
@property (nonatomic,assign) NSInteger disableMinDay;
@property (nonatomic,assign) NSInteger disableMaxYear;
@property (nonatomic,assign) NSInteger disableMaxMonth;
@property (nonatomic,assign) NSInteger disableMaxDay;

@property (nonatomic,assign) NSInteger todayYear;
@property (nonatomic,assign) NSInteger todayMonth;
@property (nonatomic,assign) NSInteger todayDay;
@property (nonatomic,strong) NSDate * todayDate;

@property (nonatomic,strong) NSMutableArray<DDDateSection *> * monthItems;
@property (nonatomic,assign) BOOL openMinDisable;
@property (nonatomic,assign) BOOL openMaxDisable;

@end

@implementation DDCalendarManager

- (instancetype)initWithMinDate:(NSDate *)minDate
                        maxDate:(NSDate *)maxDate{
    return [self initWithMinDate:minDate maxDate:maxDate disableLastDate:nil disableNextDate:nil];
}

- (instancetype)initWithMinDate:(NSDate *)minDate
                        maxDate:(NSDate *)maxDate
                 disableLastDate:(NSDate *)disableLastDate
                 disableNextDate:(NSDate *)disableNextDate{
    self = [super init];
    if (self) {
        if(NSOrderedDescending == [minDate compare:maxDate]){
            NSLog(@"error: minDate不能大于maxDate");
        }else{
            NSInteger minyear = 0;
            NSInteger minmonth = 0;
            NSInteger minday = 0;
            [minDate year:&minyear month:&minmonth day:&minday];
            self.minYear = minyear;
            self.minMonth = minmonth;
            self.minDay = minday;
            
            NSInteger maxyear = 0;
            NSInteger maxmonth = 0;
            NSInteger maxday = 0;
            [maxDate year:&maxyear month:&maxmonth day:&maxday];
            self.maxYear = maxyear;
            self.maxMonth = maxmonth;
            self.maxDay = maxday;
            
            if(disableLastDate){
                NSInteger disableminyear = 0;
                NSInteger disableminmonth = 0;
                NSInteger disableminday = 0;
                [disableLastDate year:&disableminyear month:&disableminmonth day:&disableminday];
                self.disableMinYear = disableminyear;
                self.disableMinMonth = disableminmonth;
                self.disableMinDay = disableminday;
                
                self.openMinDisable = YES;
            }
            if(disableNextDate){
                NSInteger disablemaxyear = 0;
                NSInteger disablemaxmonth = 0;
                NSInteger disablemaxday = 0;
                [disableNextDate year:&disablemaxyear month:&disablemaxmonth day:&disablemaxday];
                self.disableMaxYear = disablemaxyear;
                self.disableMaxMonth = disablemaxmonth;
                self.disableMaxDay = disablemaxday;
                
                self.openMaxDisable = YES;
            }
            [self setupData];
        }
    }
    return self;
}

- (void)setupData{
    self.monthItems = [NSMutableArray new];
    [self resetTodayDate];
}

- (void)resetTodayDate{
    self.todayDate = [NSDate date];
    
    NSInteger year = 0;
    NSInteger month = 0;
    NSInteger day = 0;
    [_todayDate year:&year month:&month day:&day];
    self.todayYear = year;
    self.todayMonth = month;
    self.todayDay = day;
}

- (void)monthEnlarge{
    
    NSInteger lastMonthCount = (self.todayYear-self.minYear-1)*12+self.todayMonth+12-self.minMonth+1;
    NSInteger nextMonthCount = (self.maxYear-self.todayYear)*12+self.maxMonth-self.todayMonth;
    _currentMonthIndex = lastMonthCount;
    
    NSMutableArray * lastMonthItems = [NSMutableArray new];
    NSMutableArray * nextMonthItems = [NSMutableArray new];
    for(NSInteger i=lastMonthCount-1,index = 0;i>=0;i--,index ++){
        NSDate * lastOffsetMonth = [self.todayDate offsetByMonth:-i];
        DDDateSection * monthSection = [self dayItemsInMonth:lastOffsetMonth todayYear:self.todayYear todayMonth:self.todayMonth today:self.todayDay];
        [lastMonthItems addObject:monthSection];
    }
    for(NSInteger i=1;i<=nextMonthCount;i++){
        NSDate * nextOffsetMonth = [self.todayDate offsetByMonth:i];
        DDDateSection * monthSection = [self dayItemsInMonth:nextOffsetMonth todayYear:self.todayYear todayMonth:self.todayMonth today:self.todayDay];
        [nextMonthItems addObject:monthSection];
    }
    [self.monthItems addObjectsFromArray:lastMonthItems];
    [self.monthItems addObjectsFromArray:nextMonthItems];
}

- (DDDateSection *)dayItemsInMonth:(NSDate *)date todayYear:(NSInteger)todayYear todayMonth:(NSInteger)todayMonth today:(NSInteger)today{
    
    DDDateSection * section = [DDDateSection new];
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
        DDDateItem * item = [DDDateItem new];
        if(i < firstWeekday){
            item.year = -1;
            item.month = -1;
            item.day = -1;
        }else{
            item.year = year;
            item.month = month;
            item.day = i-firstWeekday+1;
            if(year == todayYear && month == todayMonth && today == item.day){
                item.today = YES;
                //item.selected = YES;
            }
            
            if(self.openMinDisable){
                BOOL eqYear = (year == _disableMinYear);
                BOOL eqMonth = (month == _disableMinMonth);
                
                if(year < _disableMinYear){
                    item.disable = YES;
                }else if (eqYear && month < _disableMinMonth){
                    item.disable = YES;
                }else if (eqYear && eqMonth && _disableMinDay > item.day){
                    item.disable = YES;
                }
            }
            if(self.openMaxDisable){
                BOOL eqYear = (year == _disableMaxYear);
                BOOL eqMonth = (month == _disableMaxMonth);
                if(year > _disableMaxYear){
                    item.disable = YES;
                }else if (eqYear && month > _disableMaxMonth){
                    item.disable = YES;
                }else if (eqMonth && month == _disableMaxMonth && _disableMaxDay < item.day){
                    item.disable = YES;
                }
            }
        }
        [dayItems addObject:item];
    }
    section.dayItems = dayItems;
    return section;
}

- (void)prepare{
    [self resetTodayDate];
    [self monthEnlarge];
}

@end
