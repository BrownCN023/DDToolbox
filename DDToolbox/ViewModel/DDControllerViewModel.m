//
//  DDControllerViewModel.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@implementation DDControllerViewModel

- (instancetype)initWithData:(id)data delegate:(id<DDControllerViewModelDelegate>)delegate controller:(UIViewController *)controller{
    if(self = [super initWithData:data delegate:delegate]){
        self.controller = controller;
    }
    return self;
}

@end
