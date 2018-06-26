//
//  CircleArcViewLayout.m
//  UICollectionViewDemo
//
//  Created by TongAn001 on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "CircleArcViewLayout.h"

@interface CircleArcViewLayout()

@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat viewHeight;
@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,strong) NSMutableArray * attributesArray;

@end

@implementation CircleArcViewLayout

//预布局方法 所有的布局应该写在这里面
- (void)prepareLayout {
    [super prepareLayout];
    _viewWidth = CGRectGetWidth(self.collectionView.frame);
    _viewHeight = CGRectGetHeight(self.collectionView.frame);
    self.itemSize = CGSizeMake(_viewWidth, _viewHeight);
    
    [self.attributesArray removeAllObjects];
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0]/3;
    for (int i = 0; i < itemCount; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArray addObject:attributes];
    }
}

//返回当前的ContentSize
- (CGSize)collectionViewContentSize{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0]/3;
    CGFloat itemWidth = _viewWidth;
    return  CGSizeMake(itemWidth*itemCount, _viewHeight);
}

//此方法应该返回当前屏幕正在显示的视图（cell 头尾视图）的布局属性集合（UICollectionViewLayoutAttributes 对象集合）
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

//根据indexPath去对应的UICollectionViewLayoutAttributes  这个是取值的，要重写，在移动删除的时候系统会调用改方法重新去UICollectionViewLayoutAttributes然后布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(_viewWidth*indexPath.item, 0, _viewWidth, _viewHeight);
    
    CGFloat cY = self.collectionView.contentOffset.x + _viewHeight / 2;
    CGFloat attributesY = _viewHeight * indexPath.row + _viewHeight / 2;
    CGFloat delta = cY - attributesY;
    CGFloat ratio =  - delta / (_viewHeight * 2);
    attributes.transform = CGAffineTransformScale(attributes.transform, ratio, 1.0);
    
    return attributes;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    CGFloat index = roundf((proposedContentOffset.x+ self.viewHeight / 2 - self.viewHeight / 2) / self.viewHeight);
//    proposedContentOffset.x = self.viewHeight * index + self.viewHeight / 2 - self.viewHeight / 2;
//    return proposedContentOffset;
//}
//
//是否重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

- (NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

@end
