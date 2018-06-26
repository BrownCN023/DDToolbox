//
//  DDSimpleTableViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleTableViewController.h"

@interface DDSimpleTableViewController ()

@end

@implementation DDSimpleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)contentHeight{
    if(self.fixedRowHeight > 0.0f){
        CGFloat maxHeight = DDModal_ScreenHeight-150-self.topHeight;
        CGFloat targetHeight = self.items.count*self.fixedRowHeight;
        if(targetHeight > maxHeight){
            return maxHeight;
        }
        return targetHeight;
    }
    return 380.0f;
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.fixedRowHeight > 0.0f){
        return self.fixedRowHeight;
    }
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    id item = self.items[indexPath.row];
    cell.textLabel.text = self.itemTitleKeyPath?[item valueForKeyPath:self.itemTitleKeyPath]:item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = self.items[indexPath.row];
    [self dismiss:^{
        if(self.onClickItemBlock){
            self.onClickItemBlock(indexPath, item);
        }
    }];
}

@end
