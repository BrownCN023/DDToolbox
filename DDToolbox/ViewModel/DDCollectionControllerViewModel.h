//
//  DDCollectionControllerViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@interface DDCollectionControllerViewModel : DDControllerViewModel

@property (nonatomic,weak) UICollectionView * collectionView;

- (instancetype)initWithData:(id)data collectionView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController;

@end
