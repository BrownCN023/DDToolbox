//
//  DDSimpleInputViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleInputViewController.h"
#import "DDMacro.h"
#import <Masonry/Masonry.h>

@interface DDSimpleInputAlertTextField : UITextField

@end

@implementation DDSimpleInputAlertTextField
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 7 , 0 );
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 7 , 0 );
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectInset( bounds , 7 , 0 );
}
@end



@interface DDSimpleInputViewController ()

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^submitBlock)(NSString * text);
@property (nonatomic,copy) BOOL (^validationBlock)(NSString * text);

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) DDSimpleInputAlertTextField * textField;

@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * okButton;

@property (nonatomic,strong) UIView * bottomTopLineView;
@property (nonatomic,strong) UIView * bottomVLineView;

@end

@implementation DDSimpleInputViewController

+ (void)showAlert:(NSString *)title text:(NSString *)text placeholder:(NSString *)placeholder onCancelBlock:(void (^)(void))cancelBlock onSubmitBlock:(void (^)(NSString * text))submitBlock onValidationBlock:(BOOL (^)(NSString * text))validationBlock{
    DDSimpleInputViewController * vctl = [[DDSimpleInputViewController alloc] init];
    vctl.alertTitle = title;
    vctl.textField.text = text;
    vctl.textField.placeholder = placeholder;
    vctl.cancelBlock = cancelBlock;
    vctl.submitBlock = submitBlock;
    vctl.validationBlock = validationBlock;
    [vctl show:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleKeyboardWillShow:(NSNotification *)noti{
    CGRect endRect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat targetCentY = CGRectGetHeight(endRect)+40;
    [UIView animateWithDuration:0.25 animations:^{
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-targetCentY);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)handleKeyboardWillHide:(NSNotification *)noti{
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-self.alertMarginBottom);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (CGFloat)contentHeight{
    return 70.0f;
}

- (void)tapModalView:(UITapGestureRecognizer *)tapGes{
    //[self.view endEditing:YES];
}

- (void)viewShowAnimation:(void (^)(void))completion{
    void (^_completion)(void) = ^{
        if(completion){
            completion();
        }
        [self.textField becomeFirstResponder];
    };
    [super viewShowAnimation:_completion];
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.topView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addSubview:self.okButton];
    [self.bottomView addSubview:self.bottomTopLineView];
    [self.bottomView addSubview:self.bottomVLineView];
    
}
- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.right.equalTo(self.topView).offset(-15);
        make.top.bottom.equalTo(self.topView).offset(0);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
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
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.left.equalTo(self.bottomVLineView.mas_right);
        make.top.bottom.equalTo(self.bottomView);
    }];
}

- (void)clickCancelButton:(UIButton *)sender{
    [self.view endEditing:YES];
    [self dismiss:nil];
}

- (void)clickSubmitButton:(UIButton *)sender{
    NSString * text = self.textField.text;
    if(self.validationBlock){
        BOOL suc = self.validationBlock(text);
        if(!suc){
            return;
        }
    }
    [self.view endEditing:YES];
    [self dismiss:^{
        if(self.submitBlock){
            self.submitBlock(text);
        }
    }];
}

- (DDSimpleInputAlertTextField *)textField{
    if(!_textField){
        DDSimpleInputAlertTextField * v = [[DDSimpleInputAlertTextField alloc] init];
        v.backgroundColor = DD_COLOR_Hex(0xF6F6F9);
        //v.font = [UIFont systemFontOfSize:18];
        _textField = v;
    }
    return _textField;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        //        v.backgroundColor = DD_COLOR_Random();
        v.text = self.alertTitle;
        v.textColor = [UIColor whiteColor];
        v.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:@"取消" forState:UIControlStateNormal];
        //        v.backgroundColor = DD_COLOR_Random();
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        _cancelButton = v;
    }
    return _cancelButton;
}

- (UIButton *)okButton{
    if(!_okButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:@"确定" forState:UIControlStateNormal];
        //        v.backgroundColor = DD_COLOR_Random();
        [v addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        _okButton = v;
    }
    return _okButton;
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
