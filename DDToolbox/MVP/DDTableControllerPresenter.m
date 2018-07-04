//
//  DDTableControllerPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDTableControllerPresenter.h"

@implementation DDTableControllerPresenter

- (instancetype)initWithView:(UITableView *)tableView{
    self = [super initWithView:tableView];
    if (self) {
        _tableView = tableView;
    }
    return self;
}

- (instancetype)initWithView:(UITableView *)tableView viewController:(UIViewController *)viewController{
    self = [super initWithView:tableView viewController:viewController];
    if (self) {
        _tableView = tableView;
    }
    return self;
}

@end
