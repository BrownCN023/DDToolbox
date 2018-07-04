//
//  DDAutoLoopCollectionView.m
//  DDTooboxDemo
//
//  Created by brown on 2018/7/4.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDAutoLoopCollectionView.h"
#import "DDTimer.h"
#import "DDMacro.h"

@interface DDAutoLoopCollectionView()

@property (nonatomic,strong) DDTimer * timer;
@property (nonatomic,assign) NSInteger rowIndex;

@end

@implementation DDAutoLoopCollectionView

- (void)dealloc{
    [self endLoopScroll];
}

- (void)startLoopScroll{
    [self startTimer];
}

- (void)endLoopScroll{
    [self stopTimer];
}

- (CGFloat)intervalTime{
    if(self.rollingInterval <= 0.0f){
        return 7.0f;
    }
    return self.rollingInterval;
}

- (void)setRollingInterval:(CGFloat)rollingInterval{
    _rollingInterval = rollingInterval;
    if(self.timer.isStarting){
        [self stopTimer];
        self.timer = nil;
        [self startTimer];
    }
}

- (void)startTimer{
    if(!self.timer){
        __weak typeof(self) weakself = self;
        self.timer = [[DDTimer alloc] initWithDelayTime:self.intervalTime intervalTime:self.intervalTime handler:^{
            DD_GCD_Main_AsyncSafe(^{
                [weakself autoScroll];
            });
        }];
    }
    [self.timer start];
}

- (void)stopTimer{
    [self.timer stop];
}

- (void)autoScroll{
        self.rowIndex ++;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.rowIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
    [self stopTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex{
    self.rowIndex = rowIndex;
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:0.5];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView itemIndex:(NSInteger)itemIndex rowIndex:(NSInteger)rowIndex actualRowCount:(NSInteger)actualRowCount virtualRowCount:(NSInteger)virtualRowCount{
    rowIndex = (rowIndex == virtualRowCount-1)?(actualRowCount-1):rowIndex;
    self.rowIndex = rowIndex;
}

@end
