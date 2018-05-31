//
//  DDSimpleDateAlertViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"
#import "DDSimpleDateCalendarManager.h"

@interface DDSimpleDateAlertViewController : DDSimpleAlertViewController

@property (nonatomic,copy) void (^onSelectedItemBlock)(NSInteger year,NSInteger month,NSInteger day);

- (instancetype)initWithCalendarManager:(DDSimpleDateCalendarManager *)calendarManager;



@end
