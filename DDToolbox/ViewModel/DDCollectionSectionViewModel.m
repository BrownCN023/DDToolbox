//
//  DDCollectionSectionViewModel.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionSectionViewModel.h"

@implementation DDCollectionSectionViewModel

- (void)setupData{
    [super setupData];
    self.rowArray = [NSMutableArray new];
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end
