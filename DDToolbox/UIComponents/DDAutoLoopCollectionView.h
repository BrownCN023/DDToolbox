//
//  DDAutoLoopCollectionView.h
//  DDTooboxDemo
//
//  Created by brown on 2018/7/4.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDLoopCollectionView.h"

@interface DDAutoLoopCollectionView : DDLoopCollectionView

@property (nonatomic,assign) CGFloat rollingInterval;  //default 7.0s
- (void)startLoopScroll;
- (void)endLoopScroll;

@end
