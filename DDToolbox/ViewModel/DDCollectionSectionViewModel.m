//
//  DDCollectionSectionViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionSectionViewModel.h"

@implementation DDCollectionSectionViewModel

- (void)setupData{
    [super setupData];
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

- (NSMutableArray *)rowArray{
    if(!_rowArray){
        _rowArray = [NSMutableArray new];
    }
    return _rowArray;
}

@end
