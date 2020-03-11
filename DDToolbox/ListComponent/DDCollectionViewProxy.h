//
//  DDCollectionViewProxy.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDListComponentHeader.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DDCollectionViewEventDelegate <NSObject>

@optional
- (void)collectionViewEvent:(UICollectionView *)collectionView
       didSelectAtIndexPath:(NSIndexPath *)indexPath
               sectionModel:(id<DDCollectionSectionProtocol>)sectionModel
                  itemModel:(id<DDCollectionItemProtocol>)itemModel;

@end


@interface DDCollectionSectionViewModel : NSObject<DDCollectionSectionProtocol>
@property (nonatomic,strong) NSMutableArray<DDCollectionItemProtocol> * itemArray;
@end

@interface DDCollectionViewProxy : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray<DDCollectionSectionProtocol> * sectionArray;
@property (nonatomic,weak) id<DDCollectionViewEventDelegate> eventDelegate;
@property (nonatomic,weak) id eventHandler;

@end


NS_ASSUME_NONNULL_END
