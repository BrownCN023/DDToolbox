//
//  DDSimpleDateAlertWeekView.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleDateAlertWeekView.h"

@implementation DDSimpleDateAlertWeekView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubviews];
    }
    return self;
}


#pragma mark - Setup
- (void)setupSubviews{
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    
    UILabel * label0 = [[UILabel alloc] init];
    label0.font = [UIFont boldSystemFontOfSize:14];
    label0.text = @"日";
    label0.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label0];
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.font = [UIFont boldSystemFontOfSize:14];
    label1.text = @"一";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] init];
    label2.font = [UIFont boldSystemFontOfSize:14];
    label2.text = @"二";
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc] init];
    label3.font = [UIFont boldSystemFontOfSize:14];
    label3.text = @"三";
    label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label3];
    
    UILabel * label4 = [[UILabel alloc] init];
    label4.font = [UIFont boldSystemFontOfSize:14];
    label4.text = @"四";
    label4.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label4];
    
    UILabel * label5 = [[UILabel alloc] init];
    label5.font = [UIFont boldSystemFontOfSize:14];
    label5.text = @"五";
    label5.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label5];
    
    UILabel * label6 = [[UILabel alloc] init];
    label6.font = [UIFont boldSystemFontOfSize:14];
    label6.text = @"六";
    label6.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label6];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label1);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label0.mas_right);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label2);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label3);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label4);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label5);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label4.mas_right);
        make.bottom.top.equalTo(self);
        make.width.equalTo(label6);
    }];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label5.mas_right);
        make.bottom.top.equalTo(self);
        make.right.equalTo(self).offset(-5);
    }];
}


@end
