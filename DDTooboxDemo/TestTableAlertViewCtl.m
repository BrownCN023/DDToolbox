//
//  TestTableAlertViewCtl.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "TestTableAlertViewCtl.h"
#import "TestTableViewCell.h"

@interface TestTableAlertViewCtl ()

@end

@implementation TestTableAlertViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews{
    [super setupSubviews];
}

- (CGFloat)cellRowHeight{
    return 100;
}

- (UITableViewCell *)tableAlertController:(DDTableAlertViewController *)controller tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    if(!cell){
        cell = [[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:nil options:nil].firstObject;
        
    }
    return cell;
}

@end
