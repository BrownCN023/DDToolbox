//
//  DDSimpleQRCodeScannerViewController.m
//  DDMMediatorDemo
//
//  Created by TongAn001 on 2018/8/14.
//  Copyright © 2018年 Abram. All rights reserved.
//

#import "DDSimpleQRCodeScannerViewController.h"

@interface DDSimpleQRCodeScannerViewController ()

@property (nonatomic,strong) UIButton * flashlightButton;
@property (nonatomic,assign) BOOL flashlightOpen;
@property (nonatomic,strong) UIImageView * scanLineView;
@property (nonatomic,strong) UILabel * tipLabel;

@end

@implementation DDSimpleQRCodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startScanAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopScanAnimation];
}

- (void)startScanAnimation{
    [self.scanLineView.layer addAnimation:self.scanAnimation forKey:@"scanAnimation"];
}

- (void)stopScanAnimation{
    [self.scanLineView.layer removeAllAnimations];
}

- (CAAnimation *)scanAnimation{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    rotateAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.scanLineView.center.x, CGRectGetMinY(self.cropRect)+5)];
    rotateAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.scanLineView.center.x, CGRectGetMaxY(self.cropRect)-5)];
    rotateAnimation.duration = 3;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return rotateAnimation;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupNoti{
    [super setupNoti];
}
- (void)setupNavigation{
    [super setupNavigation];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.scanLineView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.flashlightButton];
}
- (void)setupLayout{
    [super setupLayout];
}

- (void)qrCodeScannerSuccessHandler:(NSString *)valueString{
    
}

- (void)qrCodeScannerErrorHandler:(NSError *)error{
    
}

- (void)qrCodeScannerBrightnessValueHandler:(CGFloat)brightnessValue{
    if(self.flashlightOpen || brightnessValue < -1.0f){
        self.flashlightButton.hidden = NO;
        self.scanLineView.hidden = YES;
    }else{
        self.flashlightButton.hidden = YES;
        self.scanLineView.hidden = NO;
    }
    self.flashlightButton.selected = self.flashlightOpen;
}

- (void)clickFlashlightButton:(UIButton *)sender{
    if(self.flashlightOpen){
        self.flashlightOpen = NO;
        [self closeFlash];
        [self startScanAnimation];
    }else{
        self.flashlightOpen = YES;
        [self openFlash];
        [self stopScanAnimation];
    }
}

- (UIButton *)flashlightButton{
    if(!_flashlightButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = CGRectMake(0, 0, 50, 25);
        v.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.cropRect)-25);
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-flashlight-selected.png"] forState:UIControlStateSelected];
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-flashlight-normal.png"] forState:UIControlStateNormal];
        v.hidden = YES;
        [v addTarget:self action:@selector(clickFlashlightButton:) forControlEvents:UIControlEventTouchUpInside];
        _flashlightButton = v;
    }
    return _flashlightButton;
}

- (UIImageView *)scanLineView{
    if(!_scanLineView){
        UIImageView * v = [[UIImageView alloc] init];
        v.frame = CGRectMake(CGRectGetMinX(self.cropRect), CGRectGetMinY(self.cropRect), CGRectGetWidth(self.cropRect), 1.5);//241/CGRectGetWidth(self.cropRect)*12);
        v.backgroundColor = [UIColor clearColor];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
        gradientLayer.locations = @[@0.0, @0.45, @0.55, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = v.bounds;
        [v.layer addSublayer:gradientLayer];
        
        _scanLineView = v;
    }
    return _scanLineView;
}

- (UILabel *)tipLabel{
    if(!_tipLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cropRect)+10, CGRectGetWidth(self.view.bounds), 44)];
        v.text = @"将二维码放入框内，即可自动扫描";
        v.font = [UIFont systemFontOfSize:15];
        v.textAlignment = NSTextAlignmentCenter;
        v.textColor = [UIColor whiteColor];
        _tipLabel = v;
    }
    return _tipLabel;
}

@end
