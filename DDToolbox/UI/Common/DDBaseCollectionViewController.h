//
//  DDBaseCollectionViewController.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDBaseCollectionViewController : DDBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

- (UICollectionViewLayout *)collectionViewLayout;
- (void)setupRefresh;
- (void)endRefreshing;

- (void)refreshCollectionView;
- (void)refreshCollectionViewBySection:(NSInteger)section;
- (void)refreshCollectionViewByIndexPath:(NSIndexPath *)indexPath;


@end
