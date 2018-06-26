//
//  DDLoopCollectionView.m
//  DDToolboxExample
//
//  Created by brown on 2018/5/3.
//  Copyright © 2018年 ABiang. All rights reserved.

//  ---- copy https://github.com/DaMingShen/SUTableView ----

#import "DDLoopCollectionView.h"

@interface DDLoopCollectinViewDataSource : NSObject

@property (nonatomic,weak) id receiver;
@property (nonatomic,weak) id middler;

@end

@implementation DDLoopCollectinViewDataSource

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.middler respondsToSelector:aSelector]) return self.middler;
    if ([self.receiver respondsToSelector:aSelector]) return self.receiver;
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.middler respondsToSelector:aSelector]) return YES;
    if ([self.receiver respondsToSelector:aSelector]) return YES;
    return [super respondsToSelector:aSelector];
}

@end

@interface DDLoopCollectionView()

@property (nonatomic, assign) NSInteger actualRows;
@property (nonatomic, strong) DDLoopCollectinViewDataSource * loopDataSource;

@end

@implementation DDLoopCollectionView

- (void)layoutSubviews {
    [self resetContentOffsetIfNeeded];
    [super layoutSubviews];
}

- (void)resetContentOffsetIfNeeded {
    CGPoint contentOffset  = self.contentOffset;
    
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        if(layout.scrollDirection == UICollectionViewScrollDirectionHorizontal){
            //scroll over left
            if (contentOffset.x < 0.0) {
                contentOffset.x = self.contentSize.width / 3.0;
            }
            //scroll over right
            else if (contentOffset.x >= (self.contentSize.width - self.bounds.size.width)) {
                contentOffset.x = self.contentSize.width / 3.0 - self.bounds.size.width;
            }
        }else{
            //scroll over top
            if (contentOffset.y < 0.0) {
                contentOffset.y = self.contentSize.height / 3.0;
            }
            //scroll over bottom
            else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) {
                contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height;
            }
        }
        
        [self setContentOffset: contentOffset];
    }
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource{
    if(!self.loopDataSource.receiver){
        self.loopDataSource.receiver = dataSource;
    }
    [super setDataSource:(id<UICollectionViewDataSource>)self.loopDataSource];
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate{
    if(!self.loopDataSource.receiver){
        self.loopDataSource.receiver = delegate;
    }
    [super setDelegate:(id<UICollectionViewDelegate>)self.loopDataSource];
}

- (DDLoopCollectinViewDataSource *)loopDataSource{
    if(!_loopDataSource){
        _loopDataSource = [[DDLoopCollectinViewDataSource alloc] init];
        _loopDataSource.middler = self;
    }
    return _loopDataSource;
}

#pragma mark - Delegate Method Override
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger section = [self.loopDataSource.receiver numberOfSectionsInCollectionView:collectionView];
    if(section > 1){
        NSLog(@"- DDLoopCollectionView - method numberOfSectionsInCollectionView: section > 1 !!!");
    }
    return section;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.actualRows = [self.loopDataSource.receiver collectionView:collectionView numberOfItemsInSection:section];
    return self.actualRows * 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.loopDataSource.receiver collectionView:collectionView cellForItemAtIndexPath:actualIndexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    [self.loopDataSource.receiver collectionView:collectionView didSelectItemAtIndexPath:actualIndexPath];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if([self.loopDataSource.receiver respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
        [self.loopDataSource.receiver scrollViewDidEndDecelerating:scrollView];
    }
    
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    NSInteger index = 0;
    if(layout.scrollDirection == UICollectionViewScrollDirectionHorizontal){
        index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    }else{
        index = scrollView.contentOffset.y/scrollView.bounds.size.height;
    }
    NSInteger itemIndex = index%self.actualRows;
    if(self.LoopDelegate && [self.LoopDelegate respondsToSelector:@selector(loopCollectionView:itemIndex:)]){
        [self.LoopDelegate loopCollectionView:self itemIndex:itemIndex];
    }
}

@end
