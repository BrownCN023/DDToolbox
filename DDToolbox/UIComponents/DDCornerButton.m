//
//  DDCornerButton.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/18.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCornerButton.h"
#import "UIView+DDHelper.h"

@implementation DDCornerButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cornerSize = CGSizeMake(5, 5);
        self.corners = UIRectCornerAllCorners;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cornerSize = CGSizeMake(5, 5);
        self.corners = UIRectCornerAllCorners;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layerCorners:self.corners cornerSize:self.cornerSize];
}

@end
