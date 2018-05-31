//
//  DDLoadingView.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DDLoadingViewInterface <NSObject>

@required
- (void)beginLoad;
- (void)endLoading;
- (void)loadFailed;
- (void)loadNoData;
- (void)loadNetError;

@end

@interface DDLoadingView : UIView<DDLoadingViewInterface>

@property (nonatomic,copy) void (^onClickReloadingBlock)(void);

@end

@interface DDSimpleLoadingView : DDLoadingView

- (void)setupData;
- (void)setupSubviews;
- (void)setupLayout;

@end
