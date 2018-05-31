//
//  DDBaseViewController.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBaseViewController : UIViewController

@property (nonatomic,strong,readonly) UIButton * navLeftButton;
@property (nonatomic,strong,readonly) UIButton * navRightButton;

- (void)setupData;
- (void)setupNoti;
- (void)setupNavigation;
- (void)setupSubviews;
- (void)setupLayout;

- (void)clickNavLeftButton;
- (void)clickNavRightButton;

@end
