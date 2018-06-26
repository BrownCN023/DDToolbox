//
//  DDModalViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface DDModalViewController : UIViewController

@property (nonatomic,strong,readonly) UIView * modalView;

- (void)setupData;
- (void)setupSubviews;
- (void)setupLayout;

- (CGFloat)modalColorAlpha;   //default 0.4
- (CGFloat)showAnimatedDuration; //default 0.45
- (CGFloat)hideAnimatedDuration; //default 0.45
- (CGFloat)springDamping;   //default 1
- (CGFloat)springVelocity;  //default 0.1

- (void)subviewShowAnimation;
- (void)subviewHideAnimation;

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

- (void)viewShowAnimation:(void (^)(void))completion;
- (void)viewHideAnimation:(void (^)(void))completion;

- (void)tapModalView:(UITapGestureRecognizer *)tapGes;

@end
