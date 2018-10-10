//
//  DDAdvertView.m
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import "DDAdvertView.h"
#import "DDMacro.h"
#import "DDTimer.h"
#import "UIImageView+SDWebImageFadeAnimation.h"

@implementation DDAdvertConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 3;
    }
    return self;
}

@end

@interface DDAdvertView()

@property (nonatomic,strong) DDAdvertConfig * config;
@property (nonatomic,strong) DDTimer * timer;
@property (nonatomic,assign) NSInteger timeCount;

@end

@implementation DDAdvertView

- (instancetype)initWithFrame:(CGRect)frame config:(DDAdvertConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        
        [self setupData];
        [self setupSubviews];
        
        [self startTimer];
    }
    return self;
}

- (void)setupData{
    DDWeakSelf(self);
    self.timer = [[DDTimer alloc] initWithDelayTime:0 intervalTime:1.1 handler:^{
        [weakself refreshTimeCountView];
    }];
}

- (void)setupSubviews{
    [self addSubview:self.imageView];
    [self addSubview:self.skipButton];
    
    if(self.config.adImageUrl){
        [self.imageView sd_setFadeImageWithURL:[NSURL URLWithString:self.config.adImageUrl] placeholderImage:nil options:0 progress:nil completed:nil];
    }
}

- (void)startTimer{
    [self.timer start];
}

- (void)endTimer{
    [self.timer stop];
}

- (void)destory:(void (^)(void))onCompletion{
    [self endTimer];
    self.timeCount = 0;
    if(self.config.onDestoryBlock){
        self.config.onDestoryBlock();
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(onCompletion){
            onCompletion();
        }
    }];
}

- (void)tapAdImage:(UITapGestureRecognizer *)tap{
    DDWeakSelf(self);
    [self destory:^{
        if(weakself.config.onClickAdImageBlock){
            weakself.config.onClickAdImageBlock(weakself.config.adOpenUrl);
        }
    }];
}

- (void)clickSkipButton:(UIButton *)sender{
    [self destory:nil];
}

- (void)refreshTimeCountView{
    DDWeakSelf(self);
    void (^mainSafeBlock)(void) = ^{
        if(weakself.timeCount <= weakself.config.duration){
            [weakself.skipButton setTitle:[NSString stringWithFormat:@"跳过%@",@(weakself.config.duration-weakself.timeCount)] forState:UIControlStateNormal];
            weakself.timeCount ++;
        }else{
            [weakself destory:nil];
        }
    };
    DD_GCD_Main_AsyncSafe(mainSafeBlock);
}

- (UIImageView *)imageView{
    if(!_imageView){
        UIImageView * v = [[UIImageView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImage:)];
        [v addGestureRecognizer:tap];
        v.userInteractionEnabled = YES;
        _imageView = v;
    }
    return _imageView;
}

- (UIButton *)skipButton{
    if(!_skipButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = self.config.skipFrame;
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
        v.titleLabel.font = [UIFont systemFontOfSize:13];
        v.layer.cornerRadius = 3.0f;
        [v addTarget:self action:@selector(clickSkipButton:) forControlEvents:UIControlEventTouchUpInside];
        _skipButton = v;
    }
    return _skipButton;
}

@end
