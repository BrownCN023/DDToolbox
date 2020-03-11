//
//  DDTableViewModel.m
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDTableViewModel.h"

@implementation DDTableViewModel

- (id)initWithViewProxy:(DDTableViewProxy *)viewProxy
{
    self = [super init];
    if (self) {
        _viewProxy = viewProxy;
    }
    return self;
}

- (void)loadFirstPageData
{
    
}

- (void)loadNextPageData
{
    
}

- (void)loadPageData
{
    
}

- (void)setViewState:(DDListComponentViewState)viewState{
    if(_viewState != viewState){
        _viewState = viewState;
    }
    if(self.stateDelegate && [self.stateDelegate respondsToSelector:@selector(tableViewModel:viewStateDidChanged:)]){
        [self.stateDelegate tableViewModel:self viewStateDidChanged:self.viewState];
    }
}

@end