//
//  DDControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewPresenter.h"

@interface DDControllerPresenter : DDViewPresenter

@property (nonatomic,weak) UIViewController * viewController;

- (instancetype)initWithView:(UIView *)view viewController:(UIViewController *)viewController;

@end
