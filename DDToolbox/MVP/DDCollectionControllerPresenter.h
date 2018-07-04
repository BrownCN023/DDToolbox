//
//  DDCollectionControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerPresenter.h"

@interface DDCollectionControllerPresenter : DDControllerPresenter

@property (nonatomic,weak,readonly) UICollectionView * collectionView;

- (instancetype)initWithView:(UICollectionView *)collectionView;
- (instancetype)initWithView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController;

@end
