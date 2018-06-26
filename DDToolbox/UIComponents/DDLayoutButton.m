//
//  DDLayoutButton.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/3.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDLayoutButton.h"

@implementation DDLayoutButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupData];
    }
    return self;
}

- (void)setupData{
    self.titleImageInterval = 5;
    self.contentEdgeInsets = UIEdgeInsetsMake(CGFLOAT_MIN, 0, CGFLOAT_MIN, 0);
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self reLayoutSubviews];
}

- (void)reLayoutSubviews{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    
    imgViewSize = self.imageView.bounds.size;
    titleSize = self.titleLabel.bounds.size;
    btnSize = self.bounds.size;
    
    if(imgViewSize.width == 0.0f || imgViewSize.height == 0.0f || titleSize.width == 0.0f || titleSize.height == 0.0f){
        return;
    }
    
    CGFloat titleImageInterval = self.titleImageInterval;
    CGFloat heightInterval = fabs(imgViewSize.height-titleSize.height);

    imageViewEdge = UIEdgeInsetsMake(-titleImageInterval-imgViewSize.height+heightInterval, 0.5*titleSize.width, 0, -0.5*titleSize.width);
    [self setImageEdgeInsets:imageViewEdge];
    
    titleEdge = UIEdgeInsetsMake(titleImageInterval+titleSize.height+heightInterval, -0.5*imgViewSize.width-10, 0, 0.5*imgViewSize.width-10);
    [self setTitleEdgeInsets:titleEdge];
    
}

@end
