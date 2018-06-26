//
//  DDSimpleMenuViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDModalConfig.h"

typedef NS_ENUM(NSInteger,DDMenuShowDirection) {
    DDMenuShowDirectionLeft = 0,
    DDMenuShowDirectionRight
};

@interface DDSimpleMenuViewController : DDModalAlertViewController

@property (nonatomic,strong,readonly) UIView * alertView;

+ (DDSimpleMenuViewController *)showWithItems:(NSArray *)items
                                  originFrame:(CGRect)originFrame
                                showDirection:(DDMenuShowDirection)showDirection
                             onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;


@end
