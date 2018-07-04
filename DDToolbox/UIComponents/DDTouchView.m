//
//  DDTouchView.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTouchView.h"

@interface DDTouchView()

@property (nonatomic,strong) UIColor * originBackgroundColor;

@end

@implementation DDTouchView

- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor{
    _highlightBackgroundColor = highlightBackgroundColor;
    self.originBackgroundColor = self.backgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if(self.highlightBackgroundColor){
        self.backgroundColor = self.highlightBackgroundColor;
    }
    [self touchViewBegin:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if(self.originBackgroundColor){
        self.backgroundColor = self.originBackgroundColor;
    }
    CGPoint point = CGPointZero;
    for (UITouch *touch in [event allTouches]) {
        point=[touch locationInView:self];
        break;
    }
    BOOL isInside = [self pointInside:point withEvent:event];
    [self touchViewEnded:self isInside:isInside];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if(self.highlightBackgroundColor){
        self.backgroundColor = self.highlightBackgroundColor;
    }
    CGPoint point = CGPointZero;
    for (UITouch *touch in [event allTouches]) {
        point=[touch locationInView:self];
        break;
    }
    BOOL isInside = [self pointInside:point withEvent:event];
    [self touchViewMoved:self isInside:isInside];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
    if(self.originBackgroundColor){
        self.backgroundColor = self.originBackgroundColor;
    }
    [self touchViewCancelled:self];
}

- (void)touchViewBegin:(DDTouchView *)view{}
- (void)touchViewMoved:(DDTouchView *)view isInside:(BOOL)isInside{}
- (void)touchViewEnded:(DDTouchView *)view isInside:(BOOL)isInside{}
- (void)touchViewCancelled:(DDTouchView *)view{}

@end
