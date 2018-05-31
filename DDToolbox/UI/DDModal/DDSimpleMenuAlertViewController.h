//
//  DDMenuAlertViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperModalViewController.h"

typedef NS_ENUM(NSInteger,DDMenuShowDirection) {
    DDMenuShowDirectionLeft = 0,
    DDMenuShowDirectionRight
};

@interface DDSimpleMenuAlertViewController : DDSuperModalViewController

@property (nonatomic,strong,readonly) UIView * alertView;

+ (DDSimpleMenuAlertViewController *)showWithItems:(NSArray *)items originFrame:(CGRect)originFrame showDirection:(DDMenuShowDirection)showDirection onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

@end
