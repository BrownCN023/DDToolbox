//
//  DDCircleProgressView.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDCircleProgressView.h"

#define DDCircleDegreesToRadian(x) (M_PI * (x) / 180.0)       //角度转弧度
#define DDCircleRadianToDegrees(radian) (radian*180.0)/(M_PI) //弧度转角度

@interface DDCircleProgressView()

@property (nonatomic,strong) CAShapeLayer * strokeShapeLayer;
@property (nonatomic,strong) CAShapeLayer * trackShapeLayer;
@property (nonatomic,strong) UIImageView * gradientImgView;
@property (nonatomic,assign) CGFloat bkStrokeRadius;
@property (nonatomic,assign) CGFloat bkStrokeWidth;;
@property (nonatomic,assign) CGFloat bkStartAngle;
@property (nonatomic,assign) CGFloat bkEndAngle;

@end

@implementation DDCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupData];
        [self setupSubviews];
    }
    return self;
}

- (void)setupData{
    _strokeRadius = 20.0f;
    _bkStrokeRadius = _strokeRadius;
    _strokeWidth = 3.5f;
    _bkStrokeWidth = _strokeWidth;
    _startAngle = 0.0f;
    _endAngle = 360.0f;
    _bkStartAngle = _startAngle;
    _bkEndAngle = _endAngle;
    
    _trackColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    _strokeColor = [UIColor colorWithRed:54/255.0 green:171/255.0 blue:96/255.0 alpha:1.0];
    self.gradientImage = [UIImage imageNamed:@"DDCircleProgressView.bundle/gradient-0.png"];
}

- (void)setupSubviews{
    [self refreshTrackLayer];
    [self addSubview:self.gradientImgView];
    [self refreshSubviews];
    
    [self refreshTrackLayerColor];
    [self refreshStrokeLayerColor];
}

- (void)refreshTrackLayer{
    [self.layer addSublayer:self.trackShapeLayer];
}

- (void)refreshSubviews{
    if(_type == DDCircleTypeGradient){
        [self.strokeShapeLayer removeFromSuperlayer];
        self.strokeShapeLayer = nil;
        self.gradientImgView.layer.mask = self.strokeShapeLayer;
        self.gradientImgView.hidden = NO;
    }else{
        self.gradientImgView.hidden = YES;
        self.gradientImgView.layer.mask = nil;
        [self.layer addSublayer:self.strokeShapeLayer];
    }
}

- (void)setType:(DDCircleType)type{
    _type = type;
    [self refreshSubviews];
    [self refreshPercentView];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.gradientImgView.frame = self.bounds;
}

- (void)setStrokeRadius:(CGFloat)strokeRadius{
    _strokeRadius = strokeRadius;
    [self refreshPercentView];
}

- (void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    [self refreshPercentView];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self refreshPercentView];
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(circleProgressView:progress:)]){
        [self.progressDelegate circleProgressView:self progress:progress];
    }
}

- (void)setStartAngle:(CGFloat)startAngle{
    _startAngle = startAngle;
    [self refreshPercentView];
}

- (void)setEndAngle:(CGFloat)endAngle{
    _endAngle = endAngle;
    [self refreshPercentView];
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    [self refreshTrackLayerColor];
}

- (void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self refreshStrokeLayerColor];
}

- (void)setGradientImage:(UIImage *)gradientImage{
    _gradientImage = gradientImage;
    self.gradientImgView.image = gradientImage;
}

- (void)refreshStrokeLayerColor{
    self.strokeShapeLayer.strokeColor = _strokeColor.CGColor;
}

- (void)refreshTrackLayerColor{
    self.trackShapeLayer.strokeColor = _trackColor.CGColor;
}

- (void)refreshPercentView{
    if(_strokeWidth != _bkStrokeWidth){
        _bkStrokeWidth = _strokeWidth;
        self.strokeShapeLayer.lineWidth = _strokeWidth;
        self.trackShapeLayer.lineWidth = _strokeWidth;
    }
    
    BOOL resetTrackLayer = NO;
    if(_bkStartAngle != _startAngle || _bkEndAngle != _endAngle){
        _bkStartAngle = _startAngle;
        _bkEndAngle = _endAngle;
        resetTrackLayer = YES;
    }
    
    if(resetTrackLayer || _strokeRadius != _bkStrokeRadius){
        _bkStrokeRadius = _strokeRadius;
        self.trackShapeLayer.path = [self createCirclePath:_strokeRadius startAngle:DDCircleDegreesToRadian(_startAngle) endAngle:DDCircleDegreesToRadian(_endAngle)].CGPath;
    }
    self.strokeShapeLayer.path = [self createCirclePath:_strokeRadius startAngle:DDCircleDegreesToRadian(_startAngle) endAngle:DDCircleDegreesToRadian(_startAngle)+DDCircleDegreesToRadian((_endAngle-_startAngle)*_progress)].CGPath;
}

- (UIBezierPath *)createCirclePath:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    UIBezierPath * path = nil;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.flatness = CGFLOAT_MIN;
    return path;
}

- (CAShapeLayer *)trackShapeLayer{
    if(!_trackShapeLayer){
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.lineWidth = _strokeWidth;
        layer.strokeColor = _trackColor.CGColor;
        layer.lineCap = kCALineCapRound;
        layer.fillColor = nil;
        _trackShapeLayer = layer;
    }
    return _trackShapeLayer;
}

- (CAShapeLayer *)strokeShapeLayer{
    if(!_strokeShapeLayer){
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.lineWidth = _strokeWidth;
        layer.strokeColor = _strokeColor.CGColor;
        layer.lineCap = kCALineCapRound;
        layer.fillColor = nil;
        _strokeShapeLayer = layer;
    }
    return _strokeShapeLayer;
}

- (UIImageView *)gradientImgView{
    if(!_gradientImgView){
        UIImageView * v = [[UIImageView alloc] initWithFrame:self.bounds];
        v.image = self.gradientImage;
        _gradientImgView = v;
    }
    return _gradientImgView;
}

@end
