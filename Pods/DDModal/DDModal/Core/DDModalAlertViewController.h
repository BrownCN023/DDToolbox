//
//  DDModalAlertViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalPopViewController.h"
#import "DDModalThemeConfig.h"

@interface DDModalAlertViewController : DDModalPopViewController

@property (nonatomic,strong,readonly) UIView * topView;
@property (nonatomic,strong,readonly) UIView * contentView;
@property (nonatomic,strong,readonly) UIView * bottomView;

- (CGFloat)topHeight;
- (CGFloat)contentHeight;
- (CGFloat)bottomHeight;

@end
