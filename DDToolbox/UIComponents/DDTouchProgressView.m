//
//  DDTouchProgressView.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTouchProgressView.h"

#define DDTouchProgressViewDegreesToRadian(x) (M_PI * (x) / 180.0)       //角度转弧度

@interface DDTouchProgressView()<CAAnimationDelegate>{
    BOOL _isEndAnimated;
    CFTimeInterval _beginTime;
}

@property (nonatomic,strong) CAShapeLayer * strokeShapeLayer;
@property (nonatomic,strong) CAShapeLayer * trackShapeLayer;

@end

@implementation DDTouchProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self configStrokeLayer];
        [self configTrackLayer];
        [self createPath];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self configStrokeLayer];
        [self configTrackLayer];
        [self createPath];
    }
    return self;
}

- (void)setupData{
    _strokeRadius = 0.0f;
    _strokeWidth = 0.0;
    _fillColor = [UIColor whiteColor];
}

- (void)setupSubviews{
    [self.layer addSublayer:self.trackShapeLayer];
    [self.layer addSublayer:self.strokeShapeLayer];
}

#pragma mark - -----
- (CGFloat)_strokeRadius{
    if(self.strokeRadius == 0.0f){
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        CGFloat maxRadius = MIN(width, height);
        return maxRadius/2.0-self.strokeWidth/2.0;
    }
    return self.strokeRadius;
}

- (CGFloat)_maxDuration{
    if(self.maxDuration == 0.0f){
        return 10.0f;
    }
    return self.maxDuration;
}

#pragma mark - -----
- (void)createPath{
    UIBezierPath * path = [self createCirclePath:self._strokeRadius
                                      startAngle:DDTouchProgressViewDegreesToRadian(-90)
                                        endAngle:DDTouchProgressViewDegreesToRadian(270)];
    self.strokeShapeLayer.path = path.CGPath;
    
    self.trackShapeLayer.path = path.CGPath;
}

- (void)configStrokeLayer{
    _strokeShapeLayer.lineWidth = 0;
    _strokeShapeLayer.strokeColor = self.strokeColor?self.strokeColor.CGColor:[UIColor colorWithRed:255/255.0 green:194/255.0 blue:0/255.0 alpha:1.0].CGColor;
    _strokeShapeLayer.lineCap = self.strokeCap;
    _strokeShapeLayer.frame = self.bounds;
    _strokeShapeLayer.fillColor = self.fillColor?self.fillColor.CGColor:[UIColor whiteColor].CGColor;
}

- (void)configTrackLayer{
    _trackShapeLayer.lineWidth = self.strokeWidth;
    _trackShapeLayer.strokeColor = self.trackColor?self.trackColor.CGColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0].CGColor;
    _trackShapeLayer.lineCap = self.strokeCap;
    _trackShapeLayer.frame = self.bounds;
    _trackShapeLayer.fillColor = nil;
}

- (UIBezierPath *)createCirclePath:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    UIBezierPath * path = nil;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.flatness = CGFLOAT_MIN;
    return path;
}

- (void)clearAnimation{
    _strokeShapeLayer.lineWidth = 0;
    [_strokeShapeLayer removeAllAnimations];
    _strokeShapeLayer.timeOffset = 0;
    _strokeShapeLayer.speed = 1;
}

- (void)beginAnimation{
    _isEndAnimated = NO;
    
    _strokeShapeLayer.lineWidth = self.strokeWidth;
    
    //初始化动画并设置keyPath
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置代理
    basicAni.delegate = self;
    //到达位置
    basicAni.fromValue = @0;
    basicAni.toValue = @1;
    //延时执行
    //动画时间
    basicAni.duration = self._maxDuration;
    //动画节奏
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //动画速率
    //basicAni.speed = 0.1;
    //图层是否显示执行后的动画执行后的位置以及状态
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    //动画完成后是否以动画形式回到初始值
    //basicAni.autoreverses = YES;
    //动画时间偏移
    //basicAni.timeOffset = 0.5;
    //添加动画
    _beginTime = CACurrentMediaTime();
    [self.strokeShapeLayer addAnimation:basicAni forKey:@"CircleProgress"];
}

- (void)endAnimation:(BOOL)isInside{
    if(_isEndAnimated){
        return;
    }
    _isEndAnimated = YES;
    CFTimeInterval endTime = CACurrentMediaTime();
    CGFloat duration = endTime-_beginTime;
    if(duration > self._maxDuration){
        duration = self._maxDuration;
    }
    CFTimeInterval pauseTime = [_strokeShapeLayer convertTime:endTime fromLayer:nil];
    _strokeShapeLayer.timeOffset = pauseTime;
    _strokeShapeLayer.speed = 0;
    
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(touchProgressView:duration:isInside:)]){
        [self.progressDelegate touchProgressView:self duration:duration isInside:isInside];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag){
        [self endAnimation:YES];
    }
}

#pragma mark - Touch
- (void)touchViewBegin:(DDTouchView *)view{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 1.5, 1.5);
    }];
    [self clearAnimation];
    [self beginAnimation];
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(touchProgressViewBegin:)]){
        [self.progressDelegate touchProgressViewBegin:self];
    }
}
- (void)touchViewMoved:(DDTouchView *)view isInside:(BOOL)isInside{
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(touchProgressViewMoved:isInside:)]){
        [self.progressDelegate touchProgressViewMoved:self isInside:isInside];
    }
}
- (void)touchViewEnded:(DDTouchView *)view isInside:(BOOL)isInside{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    [self endAnimation:isInside];
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(touchProgressViewMoved:isInside:)]){
        [self.progressDelegate touchProgressViewEnded:self isInside:isInside];
    }
}
- (void)touchViewCancelled:(DDTouchView *)view{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    [self endAnimation:NO];
    if(self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(touchProgressViewCancelled:)]){
        [self.progressDelegate touchProgressViewCancelled:self];
    }
}

#pragma mark - Getter/Setter
- (void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    [self configStrokeLayer];
    [self configTrackLayer];
    [self createPath];
}

- (void)setStrokeRadius:(CGFloat)strokeRadius{
    _strokeRadius = strokeRadius;
    [self createPath];
}

- (void)setStrokeCap:(NSString *)strokeCap{
    _strokeCap = strokeCap;
    [self configStrokeLayer];
    [self configTrackLayer];
}

- (void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self configStrokeLayer];
}

- (void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self configStrokeLayer];
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    [self configTrackLayer];
}

- (CAShapeLayer *)strokeShapeLayer{
    if(!_strokeShapeLayer){
        CAShapeLayer * layer = [CAShapeLayer layer];
        _strokeShapeLayer = layer;
    }
    return _strokeShapeLayer;
}

- (CAShapeLayer *)trackShapeLayer{
    if(!_trackShapeLayer){
        CAShapeLayer * layer = [CAShapeLayer layer];
        _trackShapeLayer = layer;
    }
    return _trackShapeLayer;
}

@end
