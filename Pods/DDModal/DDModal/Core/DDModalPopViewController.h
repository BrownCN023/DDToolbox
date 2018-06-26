//
//  DDModalPopViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalViewController.h"
#import "UIView+DDModal.h"

typedef NS_ENUM(NSInteger,DDModalPopAnimation) {
    DDModalPopAnimationNone = 0,
    DDModalPopAnimationScale,
    DDModalPopAnimationTop,
    DDModalPopAnimationRight,
    DDModalPopAnimationBottom,
    DDModalPopAnimationLeft
};

@interface DDModalPopViewController : DDModalViewController

@property (nonatomic,strong,readonly) UIView * popView;

- (DDModalPopAnimation)showPopAnimation;
- (DDModalPopAnimation)hidePopAnimation;
- (CGFloat)popMarginLeft;
- (CGFloat)popMarginRight;
- (CGFloat)popHeight;
- (CGFloat)popMarginBottom;
- (CGSize)cornerSize;
- (UIRectCorner)corners;

@end
