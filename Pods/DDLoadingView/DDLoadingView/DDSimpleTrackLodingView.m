//
//  DDSimpleTrackLodingView.m
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDSimpleTrackLodingView.h"
@interface DDSimpleTrackLodingView()

@property (nonatomic,strong) CAShapeLayer * circleLayer1;
@property (nonatomic,strong) CAShapeLayer * circleLayer2;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * subTitleLabel;

@end

@implementation DDSimpleTrackLodingView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
        [self setupGes];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
        [self setupGes];
    }
    return self;
}

- (void)setupData{
    
}
- (void)setupSubviews{
    self.backgroundColor = [UIColor whiteColor];
    [self.layer addSublayer:self.circleLayer1];
    [self.layer addSublayer:self.circleLayer2];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
}
- (void)setupLayout{
    
}

- (void)setupGes{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    switch (self.loadingStatus) {
        case DDLoadingStatusFailed:
        case DDLoadingStatusError:
        case DDLoadingStatusNoData:{
            [self beginLoading];
        }
            break;
            
        default:
            break;
    }
}

- (void)beginLoading{
    if(self.loadingStatus != DDLoadingStatusLoading){
        self.titleLabel.hidden = YES;
        self.subTitleLabel.hidden = YES;
        [self showAnimationLayer];
        [self removeAllAnimation];
        [self.circleLayer1 addAnimation:self.animationRotate forKey:@"animationRotate"];
        [self.circleLayer2 addAnimation:self.animationRotate forKey:@"animationRotate"];
        
        [self.circleLayer1 addAnimation:self.animationStroke forKey:@"animationStroke"];
        [self.circleLayer2 addAnimation:self.animationStroke forKey:@"animationStroke"];
        
        [super beginLoading];
    }
}
- (void)endLoading{
    [super endLoading];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self hideAnimationLayer];
        [self removeAllAnimation];
        [self removeFromSuperview];
    }];
}
- (void)loadFailed{
    [super loadFailed];
    [self hideAnimationLayer];
    [self removeAllAnimation];
    self.titleLabel.text = self.configModel.failedTitle;
    self.subTitleLabel.text = self.configModel.failedSubTitle;
    [self reLayout];
}
- (void)loadError:(NSString *)msg{
    [super loadError:msg];
    [self hideAnimationLayer];
    [self removeAllAnimation];
    self.titleLabel.text = msg?msg:self.configModel.errorTitle;
    self.subTitleLabel.text = msg?nil:self.configModel.errorSubTitle;
    [self reLayout];
}
- (void)loadNoData{
    [super loadNoData];
    [self hideAnimationLayer];
    [self removeAllAnimation];
    self.titleLabel.text = self.configModel.noDataTitle;
    self.subTitleLabel.text = self.configModel.noDataSubTitle;
    [self reLayout];
    self.subTitleLabel.hidden = YES;
}

- (void)reLayout{
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
    self.titleLabel.hidden = NO;
    
    self.subTitleLabel.hidden = NO;
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.center = CGPointMake(self.titleLabel.center.x, self.titleLabel.center.y+25);
}

- (void)showAnimationLayer{
    self.circleLayer1.hidden = NO;
    self.circleLayer2.hidden = NO;
}

- (void)hideAnimationLayer{
    self.circleLayer1.hidden = YES;
    self.circleLayer2.hidden = YES;
}

- (void)removeAllAnimation{
    [self.circleLayer1 removeAllAnimations];
    [self.circleLayer2 removeAllAnimations];
}

- (CAAnimation *)animationRotate{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotateAnimation.duration = 0.65;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return rotateAnimation;
}

- (CAAnimation *)animationStroke{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @0.65;
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return animation;
}

- (void)setConfigModel:(DDLoadingViewConfig *)configModel{
    [super setConfigModel:configModel];
    self.titleLabel.textColor = configModel.titleColor;
    self.subTitleLabel.textColor = configModel.subTitleColor;
    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:configModel.trackLineRadius startAngle:0.0f endAngle:(M_PI) clockwise:YES];
    self.circleLayer1.lineWidth = configModel.trackLineWidth;
    self.circleLayer1.strokeColor = configModel.trackColor.CGColor;
    self.circleLayer1.path = path1.CGPath;
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:configModel.trackLineRadius startAngle:M_PI endAngle:(M_PI*2) clockwise:YES];
    self.circleLayer2.lineWidth = configModel.trackLineWidth;
    self.circleLayer2.strokeColor = configModel.trackColor.CGColor;
    self.circleLayer2.path = path2.CGPath;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.hidden = YES;
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.font = [UIFont systemFontOfSize:14];
        v.textColor = [UIColor lightGrayColor];
        v.hidden = YES;
        _subTitleLabel = v;
    }
    return _subTitleLabel;
}

- (CAShapeLayer *)circleLayer1{
    if(!_circleLayer1){
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:12 startAngle:0.0f endAngle:(M_PI) clockwise:YES];
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.lineWidth = 2.0;
        layer.strokeColor = [UIColor colorWithRed:54/255.0 green:171/255.0 blue:96/255.0 alpha:1.0].CGColor;
        layer.path = path.CGPath;
        layer.lineCap = kCALineCapRound;
        layer.fillColor = nil;
        _circleLayer1 = layer;
    }
    return _circleLayer1;
}

- (CAShapeLayer *)circleLayer2{
    if(!_circleLayer2){
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:12 startAngle:M_PI endAngle:(M_PI*2) clockwise:YES];
        
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.lineWidth = 2.0;
        layer.strokeColor = [UIColor colorWithRed:54/255.0 green:171/255.0 blue:96/255.0 alpha:1.0].CGColor;
        layer.path = path.CGPath;
        layer.lineCap = kCALineCapRound;
        layer.fillColor = nil;
        _circleLayer2 = layer;
    }
    return _circleLayer2;
}

@end
