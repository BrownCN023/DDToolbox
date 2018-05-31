//
//  NSString+DDHelper.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "NSString+DDHelper.h"

@implementation NSString (DDHelper)

- (NSAttributedString *)simpleAttributedString:(UIFont *)font
                                         color:(UIColor *)color
                                   lineSpacing:(CGFloat)lineSpacing
                                     alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = alignment;
    
    NSDictionary * attr = @{
                            NSParagraphStyleAttributeName:paragraphStyle,
                            NSFontAttributeName:font,
                            NSForegroundColorAttributeName:color
                            };
    return [[NSMutableAttributedString alloc] initWithString:self attributes:attr];
}

@end
