//
//  UIView+DDLoading.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "UIView+DDLoading.h"
#import <objc/runtime.h>

#define DDLoadingViewInterfaceTag 13300

@implementation UIView (DDLoading)

#pragma mark - Setter/Getter
- (void (^)(void))onLoadingBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOnLoadingBlock:(void (^)(void))onLoadingBlock{
    if(onLoadingBlock != self.onLoadingBlock){
        objc_setAssociatedObject(self, @selector(onLoadingBlock), onLoadingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (DDLoadingView * (^)(void))onLoadingView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOnLoadingView:(DDLoadingView * (^)(void))onLoadingView{
    if(onLoadingView != self.onLoadingView){
        objc_setAssociatedObject(self, @selector(onLoadingView), onLoadingView, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - Private Method
- (void)setupScrollEnabled:(BOOL)enabled{
    if([self isKindOfClass:[UIScrollView class]] || [self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]){
        UIScrollView * scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = enabled;
    }
}

#pragma mark - Public Method
- (void)beginLoad{
    [self setupScrollEnabled:NO];
    
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewInterfaceTag];
    if(!loadingView){
        if(self.onLoadingView){
            loadingView = self.onLoadingView();
        }else{
            __weak typeof(self) weakself = self;
            loadingView = [[DDSimpleLoadingView alloc] init];
            loadingView.onClickReloadingBlock = ^{
                if(weakself.onLoadingBlock){
                    weakself.onLoadingBlock();
                }
            };
        }
        loadingView.tag = DDLoadingViewInterfaceTag;
        loadingView.backgroundColor = [UIColor whiteColor];
        loadingView.userInteractionEnabled = YES;
        [self addSubview:loadingView];
        
        loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];

        NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
        
        NSArray *array = [NSArray arrayWithObjects:layoutLeft, layoutTop, layoutWidth, layoutHeight, nil];
        [self addConstraints:array];
    }
    [loadingView beginLoad];
}
- (void)endLoading{
    [self setupScrollEnabled:YES];
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewInterfaceTag];
    if(loadingView){
        [loadingView endLoading];
    }
}
- (void)loadFailed{
    [self setupScrollEnabled:NO];
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewInterfaceTag];
    if(loadingView){
        [loadingView loadFailed];
    }
}
- (void)loadNoData{
    [self setupScrollEnabled:NO];
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewInterfaceTag];
    if(loadingView){
        [loadingView loadNoData];
    }
}
- (void)loadNetError{
    [self setupScrollEnabled:NO];
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewInterfaceTag];
    if(loadingView){
        [loadingView loadNetError];
    }
}

@end
