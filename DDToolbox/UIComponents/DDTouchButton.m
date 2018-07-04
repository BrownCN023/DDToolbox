//
//  DDTouchButton.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTouchButton.h"

@interface DDTouchButton()

@property (nonatomic,strong) UIColor * originBackgroundColor;

@end

@implementation DDTouchButton

- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor{
    _highlightBackgroundColor = highlightBackgroundColor;
    self.originBackgroundColor = self.backgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if(self.highlightBackgroundColor){
        self.backgroundColor = self.highlightBackgroundColor;
    }
    [self touchButtonBegin:self];
    if(self.delegate && [self.delegate respondsToSelector:@selector(touchButtonBegin:)]){
        [self.delegate touchButtonBegin:self];
    }
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
    [self touchButtonEnded:self isInside:isInside];
    if(self.delegate && [self.delegate respondsToSelector:@selector(touchButtonEnded:isInside:)]){
        [self.delegate touchButtonEnded:self isInside:isInside];
    }
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
    [self touchButtonMoved:self isInside:isInside];
    if(self.delegate && [self.delegate respondsToSelector:@selector(touchButtonMoved:isInside:)]){
        [self.delegate touchButtonMoved:self isInside:isInside];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
    if(self.originBackgroundColor){
        self.backgroundColor = self.originBackgroundColor;
    }
    [self touchButtonCancelled:self];
    if(self.delegate && [self.delegate respondsToSelector:@selector(touchButtonCancelled:)]){
        [self.delegate touchButtonCancelled:self];
    }
}

- (void)touchButtonBegin:(DDTouchButton *)button{}
- (void)touchButtonMoved:(DDTouchButton *)button isInside:(BOOL)isInside{}
- (void)touchButtonEnded:(DDTouchButton *)button isInside:(BOOL)isInside{}
- (void)touchButtonCancelled:(DDTouchButton *)button{}

@end
