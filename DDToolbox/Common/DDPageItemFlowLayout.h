//
//  DDPageItemFlowLayout.h
//  ZYGXApp
//
//  Created by brown on 2018/1/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPageItemFlowLayout : UICollectionViewFlowLayout

/**
 初始化方法
 
 @param rowCount 行总数
 @param columnCount 列总数
 @return instance
 */
- (instancetype)initWithRowCount:(NSInteger)rowCount columnCount:(NSInteger)columnCount;

@end
