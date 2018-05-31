//
//  DDSimpleAlertViewController.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/25.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"

@interface DDSimpleAlertViewController ()

@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) UIView * bottomView;

@end

@implementation DDSimpleAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (DDSuperAlertAnimation)showAlertAnimation{
    return DDSuperAlertAnimationScale;
}
- (DDSuperAlertAnimation)hideAlertAnimation{
    return DDSuperAlertAnimationScale;
}
- (CGFloat)alertHeight{
    return self.topHeight+self.contentHeight+self.bottomHeight;
}
- (CGFloat)topHeight{
    return 48.0f;
}
- (CGFloat)contentHeight{
    return 280.0f;
}
- (CGFloat)bottomHeight{
    return 48.0f;
}
#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.alertView addSubview:self.topView];
    [self.alertView addSubview:self.contentView];
    [self.alertView addSubview:self.bottomView];
}
- (void)setupLayout{
    [super setupLayout];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.alertView);
        make.height.mas_equalTo(self.topHeight);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.alertView);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(self.contentHeight);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.alertView);
        make.height.mas_equalTo(self.bottomHeight);
    }];
}

#pragma mark - Setting/Getting
- (UIView *)topView{
    if(!_topView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        _topView = v;
    }
    return _topView;
}

- (UIView *)contentView{
    if(!_contentView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        _contentView = v;
    }
    return _contentView;
}

- (UIView *)bottomView{
    if(!_bottomView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        _bottomView = v;
    }
    return _bottomView;
}

@end
