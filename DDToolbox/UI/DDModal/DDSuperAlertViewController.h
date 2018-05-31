//
//  DDSuperAlertViewController.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/25.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperModalViewController.h"

typedef NS_ENUM(NSInteger,DDSuperAlertAnimation) {
    DDSuperAlertAnimationNone = 0,
    DDSuperAlertAnimationScale,
    DDSuperAlertAnimationTop,
    DDSuperAlertAnimationRight,
    DDSuperAlertAnimationBottom,
    DDSuperAlertAnimationLeft
};


@interface DDSuperAlertViewController : DDSuperModalViewController

@property (nonatomic,strong,readonly) UIView * alertView;

- (DDSuperAlertAnimation)showAlertAnimation;
- (DDSuperAlertAnimation)hideAlertAnimation;
- (CGFloat)alertMarginLeft;
- (CGFloat)alertMarginRight;
- (CGFloat)alertHeight;
- (CGFloat)alertMarginBottom;
- (CGSize)cornerSize;
- (UIRectCorner)corners;

@end
