//
//  DDTableControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDTableViewPresenter.h"

@interface DDTableControllerPresenter : DDTableViewPresenter

@property (nonatomic,weak) UIViewController * viewController;

- (id)initWithTableView:(UITableView *)tableView viewController:(UIViewController *)viewController;

@end
