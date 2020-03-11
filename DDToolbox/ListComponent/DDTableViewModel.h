//
//  DDTableViewModel.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDTableViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

@class DDTableViewModel;
@protocol DDTableViewStateDelegate <NSObject>

@optional
- (void)tableViewModel:(DDTableViewModel *)viewModel viewStateDidChanged:(DDListComponentViewState)viewState;

@end

@interface DDTableViewModel : NSObject

@property (nonatomic,weak,readonly) DDTableViewProxy * viewProxy;
@property (nonatomic,assign) DDListComponentViewState viewState;
@property (nonatomic,weak) id<DDTableViewStateDelegate> stateDelegate;

- (id)initWithViewProxy:(DDTableViewProxy *)viewProxy;
- (void)loadFirstPageData;
- (void)loadNextPageData;
- (void)loadPageData;

@end

NS_ASSUME_NONNULL_END
