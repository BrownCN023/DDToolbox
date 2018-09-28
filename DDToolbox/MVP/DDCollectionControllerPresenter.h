//
//  DDCollectionControllerPresenter.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCollectionViewPresenter.h"

@interface DDCollectionControllerPresenter : DDCollectionViewPresenter

@property (nonatomic,weak) UIViewController * viewController;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController;

@end
