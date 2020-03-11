//
//  DDCollectionViewCell.h
//  DDMobDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDListComponentHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewCell : UICollectionViewCell<DDCollectionCellProtocol>

@property (nonatomic,strong) id cellData;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,weak) id eventHandler;

//刷新子视图
- (void)refreshSubviewsData;

//cellData KVO需要监听的keyPath
- (NSArray<NSString *> *)keyPathOfObserverInCellData;


@end

NS_ASSUME_NONNULL_END
