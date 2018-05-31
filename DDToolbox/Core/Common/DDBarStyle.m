//
//  DDBarStyle.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDBarStyle.h"
#import "UIImage+DDHelper.h"

@implementation UINavigationBar (DDHelper)
- (void)simpleStyleColor:(UIColor *)styleColor{
    [self setBackgroundImage:[UIImage createImageWithColor:styleColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64.0f)] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    [self setTranslucent:NO];
    [self setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]}];
}
@end

@implementation UITabBar (DDHelper)
- (void)simpleStyleColor:(UIColor *)styleColor{
    [self setTranslucent:NO];
    [self setShadowImage:[UIImage new]];
    [self setBackgroundImage:[UIImage createImageWithColor:styleColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width,49.0f)]];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [self addSubview:lineView];
}
@end

@implementation DDBarStyle

@end
