//
//  DDViewPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewPresenter.h"

@implementation DDViewPresenter

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}

@end
