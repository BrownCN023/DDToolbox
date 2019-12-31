//
//  DDLayoutButton.h
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/3.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DDLayoutButtonType) {
    DDLayoutButtonTypeNormal = 0,
    DDLayoutButtonTypeTitleLeft,
    DDLayoutButtonTypeTitleRight,
    DDLayoutButtonTypeTitleTop,
    DDLayoutButtonTypeTitleBottom
};

@interface DDLayoutButton : UIButton

@property (nonatomic,assign) DDLayoutButtonType layoutType;
@property (nonatomic,assign) CGFloat layoutInterval;
@property (nonatomic,assign) CGSize layoutImageSize;
@property (nonatomic,assign) UIEdgeInsets layoutInsets;

@end
