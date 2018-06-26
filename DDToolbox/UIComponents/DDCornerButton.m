//
//  DDCornerButton.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/18.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDCornerButton.h"
#import "UIView+DDHelper.h"

@interface DDCornerButton()

@property (nonatomic,assign) CGSize originCornerSize;
@property (nonatomic,assign) UIRectCorner originCorners;

@end

@implementation DDCornerButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _cornerSize = CGSizeMake(5, 5);
        _corners = UIRectCornerAllCorners;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _cornerSize = CGSizeMake(5, 5);
        _corners = UIRectCornerAllCorners;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    BOOL needLayout = NO;
    if(_corners != self.originCorners){
        self.originCorners = _corners;
        needLayout = YES;
    }
    if(!CGSizeEqualToSize(_cornerSize, self.originCornerSize)){
        self.originCornerSize = _cornerSize;
        needLayout = YES;
    }
    if(CGSizeEqualToSize(_cornerSize, CGSizeZero)){
        needLayout = NO;
        self.layer.mask = nil;
    }else{
        (!needLayout)?:[self layerCorners:_corners cornerSize:_cornerSize];
    }
}

- (void)setCorners:(UIRectCorner)corners{
    _corners = corners;
    [self setNeedsLayout];
}

- (void)setCornerSize:(CGSize)cornerSize{
    _cornerSize = cornerSize;
    [self setNeedsLayout];
}

@end
