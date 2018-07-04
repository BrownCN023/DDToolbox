//
//  DDControllerViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@implementation DDControllerViewModel

- (instancetype)initWithData:(id)data viewController:(UIViewController *)viewController
{
    self = [super initWithData:data];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

@end
