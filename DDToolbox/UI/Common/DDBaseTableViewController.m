//
//  DDBaseTableViewController.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import <Masonry/Masonry.h>
#import "DDMacro.h"

@interface DDBaseTableViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewStyle)tableStyle{
    return UITableViewStyleGrouped;
}

#pragma mark - Setup
- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.tableView];
}
- (void)setupLayout{
    [super setupLayout];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)setupRefresh{
    //MJ
}

- (void)endRefreshing{
    //MJ
}

#pragma mark - Refresh
- (void)refreshTableView{
    [self.tableView reloadData];
}

- (void)refreshTableViewBySection:(NSInteger)section{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)refreshTableViewByIndexPath:(NSIndexPath *)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"Text";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter/Getter
- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableStyle];
        v.backgroundColor = DD_COLOR_Hex(0xefefef);//[UIColor whiteColor];
        v.delegate = self;
        v.dataSource = self;
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
        _tableView = v;
    }
    return _tableView;
}

@end
