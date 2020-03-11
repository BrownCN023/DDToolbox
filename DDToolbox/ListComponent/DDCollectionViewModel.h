//
//  DDCollectionViewModel.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDCollectionViewProxy.h"

NS_ASSUME_NONNULL_BEGIN
@class DDCollectionViewModel;
@protocol DDCollectionViewStateDelegate <NSObject>

@optional
- (void)collectionViewModel:(DDCollectionViewModel *)viewModel viewStateDidChanged:(DDListComponentViewState)viewState;

@end


@interface DDCollectionViewModel : NSObject

@property (nonatomic,weak,readonly) DDCollectionViewProxy * viewProxy;
@property (nonatomic,assign) DDListComponentViewState viewState;
@property (nonatomic,weak) id<DDCollectionViewStateDelegate> stateDelegate;

- (id)initWithViewProxy:(DDCollectionViewProxy *)viewProxy;
- (void)loadFirstPageData;
- (void)loadNextPageData;
- (void)loadPageData;

@end

NS_ASSUME_NONNULL_END
