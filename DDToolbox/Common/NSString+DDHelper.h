//
//  NSString+DDHelper.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (DDHelper)

- (NSAttributedString *)simpleAttributedString:(UIFont *)font
                                         color:(UIColor *)color
                                   lineSpacing:(CGFloat)lineSpacing
                                     alignment:(NSTextAlignment)alignment;

@end
