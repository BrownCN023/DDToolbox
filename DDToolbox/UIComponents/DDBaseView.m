//
//  DDBaseView.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseView.h"

@implementation DDBaseView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupData{
    
}

- (void)setupNoti{

}

- (void)setupSubviews{

}

- (void)setupLayout{

}

@end
