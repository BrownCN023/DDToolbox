//
//  DDTableSectionViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDTableSectionViewModel.h"

@implementation DDTableSectionViewModel

- (void)setupData{
    self.footerHeight = 0.01f;
    self.headerHeight = 0.01f;
}

- (NSMutableArray *)rowArray{
    if(!_rowArray){
        _rowArray = [NSMutableArray new];
    }
    return _rowArray;
}

@end
