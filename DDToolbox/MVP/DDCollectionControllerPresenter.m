//
//  DDCollectionControllerPresenter.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionControllerPresenter.h"

@implementation DDCollectionControllerPresenter

- (instancetype)initWithView:(UICollectionView *)collectionView{
    self = [super initWithView:collectionView];
    if (self) {
        _collectionView = collectionView;
    }
    return self;
}

- (instancetype)initWithView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController{
    self = [super initWithView:collectionView viewController:viewController];
    if (self) {
        _collectionView = collectionView;
    }
    return self;
}

@end
