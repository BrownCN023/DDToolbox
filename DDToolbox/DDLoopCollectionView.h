//
//  DDLoopCollectionView.h
//  DDToolboxExample
//
//  Created by brown on 2018/5/3.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDLoopCollectionView;
@protocol DDLoopCollectionViewDelegate <NSObject>

@optional
- (void)loopCollectionView:(DDLoopCollectionView *)collectionView itemIndex:(NSInteger)itemIndex;

@end

@interface DDLoopCollectionView : UICollectionView

@property (nonatomic,weak) id<DDLoopCollectionViewDelegate> LoopDelegate;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex actualRowCount:(NSInteger)actualRowCount virtualRowCount:(NSInteger)virtualRowCount;

@end
