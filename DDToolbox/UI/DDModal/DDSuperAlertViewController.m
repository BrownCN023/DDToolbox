//
//  DDSuperAlertViewController.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/25.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperAlertViewController.h"
#import "UIView+DDHelper.h"
#import <Masonry/Masonry.h>

@interface DDSuperAlertViewController ()
@property (nonatomic,strong) UIView * alertView;
@end

@implementation DDSuperAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (DDSuperAlertAnimation)showAlertAnimation{
    return DDSuperAlertAnimationNone;
}
- (DDSuperAlertAnimation)hideAlertAnimation{
    return DDSuperAlertAnimationNone;
}

- (CGFloat)alertMarginLeft{
    return 45.0f;
}
- (CGFloat)alertMarginRight{
    return 45.0f;
}
- (CGFloat)alertHeight{
    return 240.0f;
}
- (CGFloat)alertMarginBottom{
    return ([UIScreen mainScreen].bounds.size.height-self.alertHeight)/2.0f;
}
- (CGSize)cornerSize{
    return CGSizeMake(10, 10);
}
- (UIRectCorner)corners{
    return UIRectCornerAllCorners;
}

#pragma mark - ---------------
- (CGFloat)targetInitBottomConstant{
    if(self.showAlertAnimation == DDSuperAlertAnimationTop){
        return -[UIScreen mainScreen].bounds.size.height;
    }
    if(self.showAlertAnimation == DDSuperAlertAnimationBottom){
        return self.alertHeight;
    }
    return -self.alertMarginBottom;
}

- (CGFloat)targetInitLeftConstant{
    if(self.showAlertAnimation == DDSuperAlertAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width+self.alertMarginLeft;
    }
    if(self.showAlertAnimation == DDSuperAlertAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.alertMarginLeft;
    }
    return self.alertMarginLeft;
}

- (CGFloat)targetInitRightConstant{
    if(self.showAlertAnimation == DDSuperAlertAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width-self.alertMarginRight;
    }
    if(self.showAlertAnimation == DDSuperAlertAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.alertMarginRight;
    }
    return -self.alertMarginRight;
}

- (CGFloat)targetHideLeftConstant{
    if(self.hideAlertAnimation == DDSuperAlertAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width+self.alertMarginLeft;
    }
    if(self.hideAlertAnimation == DDSuperAlertAnimationRight){
        return [UIScreen mainScreen].bounds.size.width+self.alertMarginLeft;
    }
    return self.alertMarginLeft;
}

- (CGFloat)targetHideRightConstant{
    if(self.hideAlertAnimation == DDSuperAlertAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width-self.alertMarginRight;
    }
    if(self.hideAlertAnimation == DDSuperAlertAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.alertMarginRight;
    }
    return -self.alertMarginRight;
}

- (CGFloat)targetHideBottomConstant{
    if(self.hideAlertAnimation == DDSuperAlertAnimationTop){
        return -[UIScreen mainScreen].bounds.size.height;
    }
    return self.alertHeight;
}

- (void)subviewShowAnimation{
    
    DDSuperAlertAnimation animation = self.showAlertAnimation;
    switch (animation) {
        case DDSuperAlertAnimationTop:
        case DDSuperAlertAnimationBottom:{
            [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(-self.alertMarginBottom);
            }];
        }
            break;
        case DDSuperAlertAnimationRight:
        case DDSuperAlertAnimationLeft:{
            [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(self.alertMarginLeft);
                make.right.equalTo(self.view).offset(-self.alertMarginRight);
            }];
        }
            break;
        case DDSuperAlertAnimationScale:{
            self.alertView.transform = CGAffineTransformIdentity;
            self.alertView.alpha = 1.0f;
        }
            break;
        default:{
            self.alertView.alpha = 1.0f;
        }
            break;
    }
}
- (void)subviewHideAnimation{
    DDSuperAlertAnimation animation = self.hideAlertAnimation;
    switch (animation) {
        case DDSuperAlertAnimationTop:
        case DDSuperAlertAnimationBottom:{
            [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(self.targetHideBottomConstant);
            }];
        }
            break;
        case DDSuperAlertAnimationRight:
        case DDSuperAlertAnimationLeft:{
            [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(self.targetHideLeftConstant);
                make.right.equalTo(self.view).offset(self.targetHideRightConstant);
            }];
        }
            break;
        case DDSuperAlertAnimationScale:{
            self.alertView.transform = CGAffineTransformScale(self.alertView.transform, 0.95, 0.95);
            self.alertView.alpha = 0.0f;
        }
            break;
        default:{
            self.alertView.alpha = 0.0f;
        }
            break;
    }
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.alertView];
    [self.alertView layerCorners:self.corners cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.alertMarginLeft-self.alertMarginRight, self.alertHeight) cornerSize:self.cornerSize];
}
- (void)setupLayout{
    [super setupLayout];
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.targetInitLeftConstant);
        make.right.equalTo(self.view).offset(self.targetInitRightConstant);
        make.height.mas_equalTo(self.alertHeight);
        make.bottom.equalTo(self.view).offset(self.targetInitBottomConstant);
    }];
}

#pragma mark - Setting/Getting
- (UIView *)alertView{
    if(!_alertView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        if(self.showAlertAnimation == DDSuperAlertAnimationScale){
            v.transform = CGAffineTransformScale(v.transform, 1.05, 1.05);
            v.alpha = 0;
        }
        if(self.showAlertAnimation == DDSuperAlertAnimationNone){
            v.alpha = 0;
        }
        _alertView = v;
    }
    return _alertView;
}

@end
