//
//  DDTableControllerPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDTableControllerPresenter.h"

@implementation DDTableControllerPresenter

- (id)initWithTableView:(UITableView *)tableView viewController:(UIViewController *)viewController{
    if(self = [super initWithTableView:tableView]){
        self.viewController = viewController;
    }
    return self;
}

@end
