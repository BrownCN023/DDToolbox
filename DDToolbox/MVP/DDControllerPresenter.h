//
//  DDControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDPresenter.h"
#import <UIKit/UIKit.h>

@interface DDControllerPresenter : DDPresenter

@property (nonatomic,weak) UIViewController * viewController;

- (instancetype)initWithViewController:(UIViewController *)viewController;

@end
