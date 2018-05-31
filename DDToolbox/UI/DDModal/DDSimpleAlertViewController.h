//
//  DDSimpleAlertViewController.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/25.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperAlertViewController.h"
#import "DDToolboxThemeConfig.h"
#import <Masonry/Masonry.h>
#import "DDMacro.h"

@interface DDSimpleAlertViewController : DDSuperAlertViewController

@property (nonatomic,strong,readonly) UIView * topView;
@property (nonatomic,strong,readonly) UIView * contentView;
@property (nonatomic,strong,readonly) UIView * bottomView;

- (CGFloat)topHeight;
- (CGFloat)contentHeight;
- (CGFloat)bottomHeight;



@end
