//
//  DDSimpleLoadingView.m
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDSimpleLoadingView.h"

@interface DDSimpleLoadingView()

@property (nonatomic,strong) UIActivityIndicatorView * activityView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * messageLabel;
@property (nonatomic,strong) UIButton * actionButton;

@end

@implementation DDSimpleLoadingView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.activityView.center = self.center;
    self.imageView.center = CGPointMake(self.center.x, self.center.y-CGRectGetHeight(self.imageView.frame)/2.0f);
    self.messageLabel.center = CGPointMake(self.center.x, self.imageView.center.y+CGRectGetHeight(self.imageView.frame)/2.0f+15);
    self.actionButton.center = CGPointMake(self.center.x, self.messageLabel.center.y+CGRectGetHeight(self.messageLabel.frame)+7.5);
}

#pragma mark - Setup
- (void)setupData{
    
}
- (void)setupSubviews{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.actionButton];
    [self addSubview:self.activityView];
}
- (void)setupLayout{
    
}

#pragma mark - Loading
- (void)beginLoading{
    [super beginLoading];
    self.imageView.alpha = 0.0;
    self.actionButton.alpha = 0.0;
    self.messageLabel.alpha = 0.0;
    [self.activityView startAnimating];
}
- (void)endLoading{
    self.imageView.alpha = 0.0;
    self.actionButton.alpha = 0.0;
    self.messageLabel.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)loadFailed{
    self.imageView.image = [UIImage imageNamed:@"DDLoadingView.bundle/ddloading-failed.png"];
    self.messageLabel.text = @"网络错误";
    [self.actionButton setTitle:@"点击重试" forState:UIControlStateNormal];
    
    [self.activityView stopAnimating];
    self.imageView.alpha = 1.0;
    self.actionButton.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}
- (void)loadError:(NSString *)msg{
    self.imageView.image = [UIImage imageNamed:@"DDLoadingView.bundle/ddloading-error.png"];
    self.messageLabel.text = @"加载失败";
    [self.actionButton setTitle:@"点击重试" forState:UIControlStateNormal];
    [self.activityView stopAnimating];
    self.imageView.alpha = 1.0;
    self.actionButton.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}
- (void)loadNoData{
    self.imageView.image = [UIImage imageNamed:@"DDLoadingView.bundle/ddloading-nodata.png"];
    self.messageLabel.text = @"暂无数据";
    [self.actionButton setTitle:@"点击刷新" forState:UIControlStateNormal];
    [self.activityView stopAnimating];
    self.imageView.alpha = 1.0;
    self.actionButton.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
}

#pragma mark - Getter
- (UIActivityIndicatorView *)activityView{
    if(!_activityView){
        UIActivityIndicatorView * v = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        v.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        v.color = [UIColor grayColor];
        v.hidesWhenStopped = YES;
        v.tag = 2000;
        v.transform = CGAffineTransformScale(v.transform, 0.85, 0.85);
        _activityView = v;
    }
    return _activityView;
}

- (UIImageView *)imageView{
    if(!_imageView){
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
        v.alpha = 0;
        v.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = v;
    }
    return _imageView;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont systemFontOfSize:16];
        v.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        v.alpha = 0;
        _messageLabel = v;
    }
    return _messageLabel;
}

- (UIButton *)actionButton{
    if(!_actionButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 90, 30);
        v.titleLabel.font = [UIFont systemFontOfSize:15];
        v.layer.borderColor = v.tintColor.CGColor;
        v.layer.borderWidth = 1.0;
        v.layer.cornerRadius = 5.0f;
        v.alpha = 0;
        [v addTarget:self action:@selector(beginLoading) forControlEvents:UIControlEventTouchUpInside];
        _actionButton = v;
    }
    return _actionButton;
}

@end
