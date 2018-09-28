//
//  DDCollectionControllerPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionControllerPresenter.h"

@implementation DDCollectionControllerPresenter

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController{
    self = [super initWithCollectionView:collectionView];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

@end
