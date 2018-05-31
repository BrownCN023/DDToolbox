//
//  UIView+DDLoading.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDLoadingView.h"

@interface UIView (DDLoading)<DDLoadingViewInterface>

@property (nonatomic,copy) void (^onLoadingBlock)(void);
@property (nonatomic,copy) DDLoadingView * (^onLoadingView)(void);

@end
