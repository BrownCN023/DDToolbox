//
//  DDTableControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerPresenter.h"

@interface DDTableControllerPresenter : DDControllerPresenter

@property (nonatomic,weak,readonly) UITableView * tableView;

- (instancetype)initWithView:(UITableView *)tableView;
- (instancetype)initWithView:(UITableView *)tableView viewController:(UIViewController *)viewController;

@end
