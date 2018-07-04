//
//  DDTableControllerViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@interface DDTableControllerViewModel : DDControllerViewModel

@property (nonatomic,weak) UITableView * tableView;

- (instancetype)initWithData:(id)data tableView:(UITableView *)tableView viewController:(UIViewController *)viewController;

@end
