//
//  DDControllerViewModel.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSimpleViewModel.h"

@class DDControllerViewModel;

@protocol DDControllerViewModelDelegate <DDSimpleViewModelDelegate>
@optional
- (void)controllerViewModelDidChanged:(DDControllerViewModel *)viewModel errMsg:(NSString *)errMsg;
@end

@interface DDControllerViewModel : DDSimpleViewModel

@property (nonatomic,weak) UIViewController * controller;

- (instancetype)initWithData:(id)data delegate:(id<DDControllerViewModelDelegate>)delegate controller:(UIViewController *)controller;

@end
