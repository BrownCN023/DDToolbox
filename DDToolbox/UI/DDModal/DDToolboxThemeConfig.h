//
//  DDToolboxThemeConfig.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMacro.h"

extern int themeColor1;
extern int themeColor2;
extern int themeColor3;
extern int themeColor4;
extern int themeColor5;

@interface DDToolboxThemeConfig : NSObject

@property (nonatomic,strong) UIColor * themeColor;
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIColor * messageColor;

+ (DDToolboxThemeConfig *)sharedConfig;

@end
