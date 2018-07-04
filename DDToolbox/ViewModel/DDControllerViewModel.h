//
//  DDControllerViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"


@interface DDControllerViewModel : DDViewModel

@property (nonatomic,weak) UIViewController * viewController;

- (instancetype)initWithData:(id)data viewController:(UIViewController *)viewController;

@end
