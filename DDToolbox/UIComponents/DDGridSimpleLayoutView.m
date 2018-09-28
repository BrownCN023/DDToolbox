//
//  DDGridLayoutView.m
//  iOSDDMao
//
//  Created by TongAn001 on 2018/7/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDGridSimpleLayoutView.h"

@interface DDGridSimpleLayoutView()

@property (nonatomic,strong) NSMutableArray * gridViewArray;

@end

@implementation DDGridSimpleLayoutView

- (void)addGridSubview:(UIView *)view{
    if(self.gridViewArray.count >= self.rows*self.columns){
        return;
    }
    if(![self.gridViewArray containsObject:view]){
        [self addSubview:view];
        [self.gridViewArray addObject:view];
    }
}

- (void)removeGridSubview:(UIView *)view{
    if([self.gridViewArray containsObject:view]){
        [self.gridViewArray removeObject:view];
        [view removeFromSuperview];
    }
}

- (void)removeAllGrideSubview{
    [self.gridViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view removeFromSuperview];
    }];
    [self.gridViewArray removeAllObjects];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self reLayoutSubviews];
}

- (void)reLayoutSubviews{
    CGSize viewSize = self.bounds.size;
    CGFloat viewWidth = viewSize.width;
    CGFloat viewHeight = viewSize.height;
    CGFloat itemWidth = viewWidth/self.columns;
    CGFloat itemHeight = viewHeight/self.rows;
    
    NSInteger gridViewCount = self.gridViewArray.count;
    
    for(NSInteger i=0,gridViewIndex = 0;i<self.rows;i++){
        for(NSInteger j=0;j<self.columns;j++,gridViewIndex++){
            if(gridViewIndex >= gridViewCount){
                break;
            }
            UIView * view = [self.gridViewArray objectAtIndex:gridViewIndex];
            if(view){
                view.frame = CGRectMake(itemWidth*j, itemHeight*i, itemWidth, itemHeight);
            }
        }
    }
}

- (void)setRows:(NSUInteger)rows{
    _rows = rows;
    [self reLayoutSubviews];
}

- (void)setColumns:(NSUInteger)columns{
    _columns = columns;
    [self reLayoutSubviews];
}

- (NSMutableArray *)gridViewArray{
    if(!_gridViewArray){
        _gridViewArray = [NSMutableArray new];
    }
    return _gridViewArray;
}

@end
