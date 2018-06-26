//
//  DDCalendarAlertViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDCalendarManager.h"

@interface DDCalendarAlertViewController : DDModalAlertViewController

@property (nonatomic,copy) void (^onSelectedItemBlock)(NSInteger year,NSInteger month,NSInteger day);

- (instancetype)initWithCalendarManager:(DDCalendarManager *)calendarManager;

@end
