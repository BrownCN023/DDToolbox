//
//  DDModalPopViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalPopViewController.h"

@interface DDModalPopViewController ()

@property (nonatomic,strong) UIView * popView;

@end

@implementation DDModalPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (DDModalPopAnimation)showPopAnimation{
    return DDModalPopAnimationNone;
}
- (DDModalPopAnimation)hidePopAnimation{
    return DDModalPopAnimationNone;
}

- (CGFloat)popMarginLeft{
    return 53.0f;
}
- (CGFloat)popMarginRight{
    return 53.0f;
}
- (CGFloat)popHeight{
    return 240.0f;
}
- (CGFloat)popMarginBottom{
    return ([UIScreen mainScreen].bounds.size.height-self.popHeight)/2.0f;
}
- (CGSize)cornerSize{
    return CGSizeMake(13.5, 13.5);
}
- (UIRectCorner)corners{
    return UIRectCornerAllCorners;
}

#pragma mark - ---------------
- (CGFloat)targetInitBottomConstant{
    if(self.showPopAnimation == DDModalPopAnimationTop){
        return -[UIScreen mainScreen].bounds.size.height;
    }
    if(self.showPopAnimation == DDModalPopAnimationBottom){
        return self.popHeight;
    }
    return -self.popMarginBottom;
}

- (CGFloat)targetInitLeftConstant{
    if(self.showPopAnimation == DDModalPopAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width+self.popMarginLeft;
    }
    if(self.showPopAnimation == DDModalPopAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.popMarginLeft;
    }
    return self.popMarginLeft;
}

- (CGFloat)targetInitRightConstant{
    if(self.showPopAnimation == DDModalPopAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width-self.popMarginRight;
    }
    if(self.showPopAnimation == DDModalPopAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.popMarginRight;
    }
    return -self.popMarginRight;
}

- (CGFloat)targetHideLeftConstant{
    if(self.hidePopAnimation == DDModalPopAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width+self.popMarginLeft;
    }
    if(self.hidePopAnimation == DDModalPopAnimationRight){
        return [UIScreen mainScreen].bounds.size.width+self.popMarginLeft;
    }
    return self.popMarginLeft;
}

- (CGFloat)targetHideRightConstant{
    if(self.hidePopAnimation == DDModalPopAnimationLeft){
        return -[UIScreen mainScreen].bounds.size.width-self.popMarginRight;
    }
    if(self.hidePopAnimation == DDModalPopAnimationRight){
        return [UIScreen mainScreen].bounds.size.width-self.popMarginRight;
    }
    return -self.popMarginRight;
}

- (CGFloat)targetHideBottomConstant{
    if(self.hidePopAnimation == DDModalPopAnimationTop){
        return -[UIScreen mainScreen].bounds.size.height;
    }
    return self.popHeight;
}

- (void)subviewShowAnimation{
    
    DDModalPopAnimation animation = self.showPopAnimation;
    switch (animation) {
        case DDModalPopAnimationTop:
        case DDModalPopAnimationBottom:{
            [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(-self.popMarginBottom);
            }];
        }
            break;
        case DDModalPopAnimationRight:
        case DDModalPopAnimationLeft:{
            [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(self.popMarginLeft);
                make.right.equalTo(self.view).offset(-self.popMarginRight);
            }];
        }
            break;
        case DDModalPopAnimationScale:{
            self.popView.transform = CGAffineTransformIdentity;
            self.popView.alpha = 1.0f;
        }
            break;
        default:{
            self.popView.alpha = 1.0f;
        }
            break;
    }
}
- (void)subviewHideAnimation{
    DDModalPopAnimation animation = self.hidePopAnimation;
    switch (animation) {
        case DDModalPopAnimationTop:
        case DDModalPopAnimationBottom:{
            [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(self.targetHideBottomConstant);
            }];
        }
            break;
        case DDModalPopAnimationRight:
        case DDModalPopAnimationLeft:{
            [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(self.targetHideLeftConstant);
                make.right.equalTo(self.view).offset(self.targetHideRightConstant);
            }];
        }
            break;
        case DDModalPopAnimationScale:{
            self.popView.transform = CGAffineTransformScale(self.popView.transform, 0.95, 0.95);
            self.popView.alpha = 0.0f;
        }
            break;
        default:{
            self.popView.alpha = 0.0f;
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
    [self.view addSubview:self.popView];
    [self.popView modalLayerCorners:self.corners cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.popMarginLeft-self.popMarginRight, self.popHeight) cornerSize:self.cornerSize];
}
- (void)setupLayout{
    [super setupLayout];
    self.popView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.targetInitLeftConstant);
        make.right.equalTo(self.view).offset(self.targetInitRightConstant);
        make.height.mas_equalTo(self.popHeight);
        make.bottom.equalTo(self.view).offset(self.targetInitBottomConstant);
    }];
}

#pragma mark - Setting/Getting
- (UIView *)popView{
    if(!_popView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        if(self.showPopAnimation == DDModalPopAnimationScale){
            v.transform = CGAffineTransformScale(v.transform, 1.05, 1.05);
            v.alpha = 0;
        }
        if(self.showPopAnimation == DDModalPopAnimationNone){
            v.alpha = 0;
        }
        _popView = v;
    }
    return _popView;
}

@end
