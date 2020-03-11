//
//  UIView+DDBorder.h
//  DDTooboxDemo
//
//  Created by brown on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DDBorderType) {
    DDBorderTypeTop = 0,
    DDBorderTypeLeft,
    DDBorderTypeBottom,
    DDBorderTypeRight
};

@interface UIView (DDBorder)

- (void)simpleBorder:(DDBorderType)type width:(CGFloat)width color:(UIColor *)color;

@end
