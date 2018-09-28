//
//  DDCollectionViewPresenter.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import "DDPresenter.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewPresenter : DDPresenter<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak) UICollectionView * collectionView;

- (id)initWithCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
