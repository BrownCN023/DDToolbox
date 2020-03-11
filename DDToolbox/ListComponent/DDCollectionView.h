//
//  DDCollectionView.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCollectionViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

@class DDCollectionView;
typedef DDCollectionView * _Nonnull (^DDCollectionSetupViewProxyBlock)(DDCollectionViewProxy * viewProxy);

@interface DDCollectionView : UICollectionView

@property (nonatomic,strong,readonly) DDCollectionViewProxy * viewProxy;
@property (nonatomic,strong,readonly) DDCollectionSetupViewProxyBlock setupViewProxyBlock;

+ (DDCollectionView *)createCollectionView:(void (^)(DDCollectionView * _Nonnull collectionView))configBlock;

@end

NS_ASSUME_NONNULL_END
