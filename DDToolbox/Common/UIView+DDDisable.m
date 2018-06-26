//
//  UIView+DDDisable.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "UIView+DDDisable.h"
#import <objc/runtime.h>

@implementation UIView (DDDisable)

#pragma mark - Setter/Getter
- (BOOL)disable{
    NSNumber * obj = objc_getAssociatedObject(self, _cmd);
    return obj.boolValue;
}

- (void)setDisable:(BOOL)disable{
    if(disable != self.disable){
        objc_setAssociatedObject(self, @selector(disable), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIView * disableView = [self viewWithTag:DDDisableViewTag];
    if(disable){
        if(!disableView){
            disableView = [[UIView alloc] init];
            disableView.tag = DDDisableViewTag;
            disableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
            disableView.userInteractionEnabled = YES;
            [self addSubview:disableView];
            
            disableView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *layoutTop = [NSLayoutConstraint constraintWithItem:disableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
            
            NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:disableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
            
            NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:disableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
            
            NSLayoutConstraint *layoutHeight = [NSLayoutConstraint constraintWithItem:disableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
            
            NSArray *array = [NSArray arrayWithObjects:layoutLeft, layoutTop, layoutWidth, layoutHeight, nil];
            [self addConstraints:array];
        }
    }else{
        if(disableView){
            [disableView removeFromSuperview];
        }
    }
}

@end
