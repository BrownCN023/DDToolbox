//
//  UIView+DDHelper.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDHelper)

- (void)layerCorners:(UIRectCorner)corners cornerSize:(CGSize)cornerSize;
- (void)layerCorners:(UIRectCorner)corners cornerRect:(CGRect)cornerRect cornerSize:(CGSize)cornerSize;

- (NSLayoutConstraint *)simpleLayoutToView:(UIView *)toView attribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

@end
