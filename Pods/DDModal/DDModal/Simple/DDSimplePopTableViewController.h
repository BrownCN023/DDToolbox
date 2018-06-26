//
//  DDSimplePopTableViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"

@interface DDSimplePopTableViewController : DDModalAlertViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong,readonly) UITableView * tableView;
@property (nonatomic,strong,readonly) UILabel * titleLabel;
@property (nonatomic,strong,readonly) UIButton * closeButton;
@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) void (^onCancelBlock)(void);
@property (nonatomic,copy) void (^onClickItemBlock)(NSIndexPath * indexPath,id itemObj);

@end
