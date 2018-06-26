//
//  UIView+DDLoading.m
//  DDLoadingViewDemo
//
//  Created by Brown on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "UIView+DDLoading.h"
#import <objc/runtime.h>


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

- (Class (^)(void))loadingViewClass{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLoadingViewClass:(Class (^)(void))loadingViewClass{
    if(loadingViewClass != self.loadingViewClass){
        objc_setAssociatedObject(self, @selector(loadingViewClass), loadingViewClass, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (void (^)(DDLoadingViewConfig * configModel))loadingConfigBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLoadingConfigBlock:(void (^)(DDLoadingViewConfig * configModel))loadingConfigBlock{
    if(loadingConfigBlock != self.loadingConfigBlock){
        objc_setAssociatedObject(self, @selector(loadingConfigBlock), loadingConfigBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSInteger)scrollEnableCount{
    NSNumber * obj = objc_getAssociatedObject(self, _cmd);
    return obj.boolValue;
}

- (void)setScrollEnableCount:(BOOL)scrollEnableCount{
    if(scrollEnableCount != self.scrollEnableCount){
        objc_setAssociatedObject(self, @selector(scrollEnableCount), @(scrollEnableCount), OBJC_ASSOCIATION_ASSIGN);
    }
}

#pragma mark - Private Method
- (void)setupScrollEnableNO{
    if([self isKindOfClass:[UIScrollView class]]){
        UIScrollView * scrollView = (UIScrollView *)self;
        NSInteger enableCount = self.scrollEnableCount;
        if(enableCount == 0){ //0初始化  1可用  2不可用
            if(scrollView.scrollEnabled){
                [self setScrollEnableCount:1];
            }else{
                [self setScrollEnableCount:2];
            }
        }
        scrollView.scrollEnabled = NO;
    }
}

- (void)setupScrollEnableYES{
    if([self isKindOfClass:[UIScrollView class]]){
        UIScrollView * scrollView = (UIScrollView *)self;
        NSInteger enableCount = self.scrollEnableCount;
        if(enableCount == 0){ //0初始化  1可用  2不可用
            //不做处理
        }else if (enableCount == 1){
            scrollView.scrollEnabled = YES;
        }else if (enableCount == 2){
            scrollView.scrollEnabled = NO;
        }
    }
}

- (DDLoadingView *)currentLoadingView{
    DDLoadingView * loadingView = [self viewWithTag:DDLoadingViewTag];
    return loadingView;
}

#pragma mar - Loading
- (void)beginLoading{
    [self setupScrollEnableNO];
    DDLoadingView * loadingView = [self currentLoadingView];
    if(!loadingView){
        if(self.loadingViewClass){
            Class viewClass = self.loadingViewClass();
            loadingView = [[viewClass alloc] initWithFrame:self.bounds];
        }else{
            __weak typeof(self) weakself = self;
            loadingView = [[NSClassFromString(@"DDSimpleTrackLodingView") alloc] initWithFrame:self.bounds];
            loadingView.onClickLoadingBlock = ^{
                if(weakself.onLoadingBlock){
                    weakself.onLoadingBlock();
                }
            };
        }
        loadingView.tag = DDLoadingViewTag;
        [self addSubview:loadingView];
        
        DDLoadingViewConfig * configModel = [[DDLoadingViewConfig alloc] init];
        if(self.loadingConfigBlock){
            self.loadingConfigBlock(configModel);
        }
        loadingView.configModel = configModel;
        
        loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:loadingView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
        
        NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
        
        NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
        
        NSArray *array = [NSArray arrayWithObjects:layoutLeft, layoutTop, layoutWidth, layoutHeight, nil];
        [self addConstraints:array];
    }
    [loadingView beginLoading];
}
- (void)endLoading{
    [self setupScrollEnableYES];
    DDLoadingView * loadingView = [self currentLoadingView];
    if(loadingView){
        [loadingView endLoading];
    }
}
- (void)loadFailed{
    DDLoadingView * loadingView = [self currentLoadingView];
    if(loadingView){
        [self setupScrollEnableNO];
        [loadingView loadFailed];
    }
}
- (void)loadError:(NSString *)msg{
    DDLoadingView * loadingView = [self currentLoadingView];
    if(loadingView){
        [self setupScrollEnableNO];
        [loadingView loadError:msg];
    }
}
- (void)loadNoData{
    DDLoadingView * loadingView = [self currentLoadingView];
    if(loadingView){
        [self setupScrollEnableNO];
        [loadingView loadNoData];
    }
}

@end
