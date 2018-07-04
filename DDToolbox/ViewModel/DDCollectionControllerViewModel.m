//
//  DDCollectionControllerViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionControllerViewModel.h"

@implementation DDCollectionControllerViewModel

- (instancetype)initWithData:(id)data collectionView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController{
    self = [super initWithData:data viewController:viewController];
    if (self) {
        self.collectionView = collectionView;
    }
    return self;
}

@end
