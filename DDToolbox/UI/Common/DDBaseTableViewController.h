//
//  DDBaseTableViewController.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDBaseTableViewController : DDBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

- (UITableViewStyle)tableStyle;
- (void)setupRefresh;
- (void)endRefreshing;

- (void)refreshTableView;
- (void)refreshTableViewBySection:(NSInteger)section;
- (void)refreshTableViewByIndexPath:(NSIndexPath *)indexPath;

@end
