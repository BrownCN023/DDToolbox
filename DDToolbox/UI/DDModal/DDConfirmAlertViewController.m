//
//  DDConfirmAlertViewController.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDConfirmAlertViewController.h"
#import <Masonry/Masonry.h>
#import "DDMacro.h"
#import "DDToolboxThemeConfig.h"
#import "NSString+DDHelper.h"

#define DDConfirmAlertMarginLeftRight 20.0f
#define DDConfirmAlertMarginTopBottom 15.0f

@interface DDConfirmAlertViewController ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) NSAttributedString * alertMessageAttr;

@property (nonatomic,assign) CGFloat alertMessageHeight;

@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^confirmBlock)(void);

@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * confirmButton;
@property (nonatomic,strong) UIView * bottomTopLineView;
@property (nonatomic,strong) UIView * bottomVLineView;

@end

@implementation DDConfirmAlertViewController

+ (void)showAlert:(NSString *)title message:(NSString *)message onCancelBlock:(void (^)(void))cancelBlock onConfirmBlock:(void (^)(void))confirmBlock{
    DDConfirmAlertViewController * vctl = [[DDConfirmAlertViewController alloc] init];
    vctl.alertTitle = title;
    
    if(!DD_StringIsEmpty(message)){
        vctl.alertMessageAttr = [message simpleAttributedString:[UIFont boldSystemFontOfSize:18]
                                                          color:[DDToolboxThemeConfig sharedConfig].messageColor
                                                    lineSpacing:0.5
                                                      alignment:NSTextAlignmentCenter];
        CGFloat alertMessageHeight = [vctl.alertMessageAttr
                                      boundingRectWithSize:CGSizeMake((DD_ScreenWidth-vctl.alertMarginLeft-vctl.alertMarginRight-DDConfirmAlertMarginLeftRight*2), CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      context:nil].size.height+0.1;
        vctl.alertMessageHeight = alertMessageHeight<40.0f?40.0f:alertMessageHeight;
    }
    
    vctl.cancelBlock = cancelBlock;
    vctl.confirmBlock = confirmBlock;
    [vctl show:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)topHeight{
    if(DD_StringIsEmpty(self.alertTitle)){
        return 0.0f;
    }
    return [super topHeight];
}

- (CGFloat)contentHeight{
    if(self.alertMessageHeight == 0.0f){
        return 0.0f;
    }
    return self.alertMessageHeight + DDConfirmAlertMarginTopBottom*2;
}

- (CGFloat)messageMarginTop{
    if(self.alertMessageHeight == 0.0f){
        return 0.0f;
    }
    return DDConfirmAlertMarginTopBottom;
}

- (CGFloat)messageMarginBottom{
    if(self.alertMessageHeight == 0.0f){
        return 0.0f;
    }
    return -DDConfirmAlertMarginTopBottom;
}


- (void)setupSubviews{
    [super setupSubviews];
    [self.topView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addSubview:self.confirmButton];
    [self.bottomView addSubview:self.bottomTopLineView];
    [self.bottomView addSubview:self.bottomVLineView];
}
- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.right.equalTo(self.topView).offset(-15);
        make.top.equalTo(self.topView).offset(0);
        make.bottom.equalTo(self.topView).offset(0);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(DDConfirmAlertMarginLeftRight);
        make.right.equalTo(self.contentView).offset(-DDConfirmAlertMarginLeftRight);
        make.top.equalTo(self.contentView).offset(self.messageMarginTop);
        make.bottom.equalTo(self.contentView).offset(self.messageMarginBottom);
    }];
    [self.bottomTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bottomView);
        make.height.mas_equalTo(0.5);
    }];
    [self.bottomVLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(self.bottomView);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView);
        make.right.equalTo(self.bottomVLineView.mas_left);
        make.top.bottom.equalTo(self.bottomView);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.left.equalTo(self.bottomVLineView.mas_right);
        make.top.bottom.equalTo(self.bottomView);
    }];
}


- (void)clickCancelButton:(UIButton *)sender{
    [self dismiss:^{
        if(self.cancelBlock){
            self.cancelBlock();
        }
    }];
}

- (void)clickConfirmButton:(UIButton *)sender{
    [self dismiss:^{
        if(self.confirmBlock){
            self.confirmBlock();
        }
    }];
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
//        v.backgroundColor = DD_COLOR_Random();
        v.text = self.alertTitle;
        v.textColor = [UIColor whiteColor];
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] init];
//        v.backgroundColor = DD_COLOR_Random();
        v.numberOfLines = 0;
        v.font = [UIFont boldSystemFontOfSize:17];
        v.attributedText = self.alertMessageAttr;
        _messageLabel = v;
    }
    return _messageLabel;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:@"取消" forState:UIControlStateNormal];
//        v.backgroundColor = DD_COLOR_Random();
        v.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = v;
    }
    return _cancelButton;
}

- (UIButton *)confirmButton{
    if(!_confirmButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:@"确定" forState:UIControlStateNormal];
//        v.backgroundColor = DD_COLOR_Random();
        v.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        [v addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton = v;
    }
    return _confirmButton;
}

- (UIView *)bottomTopLineView{
    if(!_bottomTopLineView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = DD_COLOR_Hex(0xE6E6E6);
        _bottomTopLineView = v;
    }
    return _bottomTopLineView;
}

- (UIView *)bottomVLineView{
    if(!_bottomVLineView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = DD_COLOR_Hex(0xE6E6E6);
        _bottomVLineView = v;
    }
    return _bottomVLineView;
}

@end
