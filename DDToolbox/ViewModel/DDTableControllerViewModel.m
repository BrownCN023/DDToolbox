//
//  DDTableControllerViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDTableControllerViewModel.h"

@implementation DDTableControllerViewModel

- (instancetype)initWithData:(id)data tableView:(UITableView *)tableView viewController:(UIViewController *)viewController{
    self = [super initWithData:data viewController:viewController];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

@end
