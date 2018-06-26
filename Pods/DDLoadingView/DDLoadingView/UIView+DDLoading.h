//
//  UIView+DDLoading.h
//  DDLoadingViewDemo
//
//  Created by Brown on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDLoadingView.h"


#define DDLoadingViewTag 100101

@interface UIView (DDLoading)<DDLoadingProtocol>

@property (nonatomic,copy) void (^onLoadingBlock)(void);
@property (nonatomic,copy) Class(^loadingViewClass)(void);  //DDLoadingView or SubViews

@property (nonatomic,copy) void (^loadingConfigBlock)(DDLoadingViewConfig * configModel);

@end
