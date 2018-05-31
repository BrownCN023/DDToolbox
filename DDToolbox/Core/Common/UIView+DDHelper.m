//
//  UIView+DDHelper.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "UIView+DDHelper.h"

@implementation UIView (DDHelper)

- (void)layerCorners:(UIRectCorner)corners cornerSize:(CGSize)cornerSize{
    [self layerCorners:corners cornerRect:self.bounds cornerSize:cornerSize];
}

- (void)layerCorners:(UIRectCorner)corners cornerRect:(CGRect)cornerRect cornerSize:(CGSize)cornerSize{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRect byRoundingCorners:corners cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cornerRect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (NSLayoutConstraint *)simpleLayoutToView:(UIView *)toView attribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier constant:(CGFloat)constant{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:relation
                                           toItem:toView
                                        attribute:attribute
                                       multiplier:multiplier
                                         constant:constant];
}

@end
