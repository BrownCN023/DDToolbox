//
//  DDControllerPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerPresenter.h"

@implementation DDControllerPresenter

- (instancetype)initWithView:(UIView *)view viewController:(UIViewController *)viewController
{
    self = [super initWithView:view];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

@end
