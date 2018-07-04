//
//  DDVideoRecordView.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDCircleRecordView.h"

@interface DDCircleRecordView()<DDTouchProgressViewDelegate>

@end

@implementation DDCircleRecordView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupData];
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
    }
    return self;
}

- (void)setupData{
    
}

- (void)setupSubviews{
    [self addSubview:self.progressView];
    [self addSubview:self.fillView];
}

- (void)touchProgressViewBegin:(DDTouchProgressView *)view{
    [UIView animateWithDuration:0.25 animations:^{
        self.fillView.transform = CGAffineTransformScale(self.transform, 0.75, 0.75);
    }];
    if(self.delegate && [self.delegate respondsToSelector:@selector(circleRecordViewBegin:)]){
        [self.delegate circleRecordViewBegin:self];
    }
}
- (void)touchProgressViewMoved:(DDTouchProgressView *)view isInside:(BOOL)isInside{
    if(self.delegate && [self.delegate respondsToSelector:@selector(circleRecordViewTouchMoved:isInside:)]){
        [self.delegate circleRecordViewTouchMoved:self isInside:isInside];
    }
}
- (void)touchProgressViewEnded:(DDTouchProgressView *)view isInside:(BOOL)isInside{
    if(self.delegate && [self.delegate respondsToSelector:@selector(circleRecordViewEnd:isInside:)]){
        [self.delegate circleRecordViewEnd:self isInside:isInside];
    }
}
- (void)touchProgressViewCancelled:(DDTouchProgressView *)view{
    if(self.delegate && [self.delegate respondsToSelector:@selector(circleRecordViewEnd:isInside:)]){
        [self.delegate circleRecordViewEnd:self isInside:NO];
    }
}

- (void)touchProgressView:(DDTouchProgressView *)view duration:(CGFloat)duration isInside:(BOOL)isInside{
    if(duration <= _minDuratin){
        [self clearAnimation:YES];;
    }else{
        [self clearAnimation:!isInside];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(circleRecordViewEnd:isInside:)]){
        [self.delegate circleRecordViewFinished:self duration:duration isInside:isInside];
    }
}

- (void)clearAnimation{
    [self clearAnimation:YES];
}

- (void)clearAnimation:(BOOL)hideAnimated{
    [UIView animateWithDuration:0.25 animations:^{
        self.fillView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            if(hideAnimated){
                self.progressView.alpha = 0.0f;
            }
        } completion:^(BOOL finished) {
            if(hideAnimated){
                [self.progressView clearAnimation];
                self.progressView.alpha = 1.0f;
            }
        }];
    }];
}


- (void)setMaxDuratin:(CGFloat)maxDuratin{
    _maxDuratin = maxDuratin;
    _progressView.maxDuration = _maxDuratin;
}

- (DDTouchProgressView *)progressView{
    if(!_progressView){
        DDTouchProgressView * v = [[DDTouchProgressView alloc] initWithFrame:self.bounds];
        v.strokeWidth = 6.5f;
        v.trackColor = [UIColor whiteColor];
        v.progressDelegate = self;
        _progressView = v;
    }
    return _progressView;
}

- (UIView *)fillView{
    if(!_fillView){
        CGFloat margin = 13.0f;
        CGFloat width = CGRectGetWidth(self.bounds)-margin*2;
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, width, width)];
        v.userInteractionEnabled = NO;
        v.backgroundColor = [UIColor colorWithRed:255/255.0 green:194/255.0 blue:0/255.0 alpha:1.0];
        v.layer.cornerRadius = width/2.0f;
        _fillView = v;
    }
    return _fillView;
}

@end
