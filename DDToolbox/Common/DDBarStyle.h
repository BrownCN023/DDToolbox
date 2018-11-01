//
//  DDBarStyle.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (DDHelper)
- (void)simpleStyleColor:(UIColor *)styleColor;
- (void)setThemeColor:(UIColor *)themeColor fontColor:(UIColor *)fontColor;
@end

@interface UITabBar (DDHelper)
- (void)simpleStyleColor:(UIColor *)styleColor;
- (void)setThemeColor:(UIColor *)themeColor tintColor:(UIColor *)tintColor;
@end

@interface DDBarStyle : NSObject

@end
