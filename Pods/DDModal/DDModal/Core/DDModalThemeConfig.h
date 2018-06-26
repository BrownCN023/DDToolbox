//
//  DDModalThemeConfig.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDModalConfig.h"

extern int modalThemeColor1;
extern int modalThemeColor2;
extern int modalThemeColor3;
extern int modalThemeColor4;
extern int modalThemeColor5;

@interface DDModalThemeConfig : NSObject

@property (nonatomic,strong) UIColor * themeColor;
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIColor * messageColor;
@property (nonatomic,strong) UIColor * tintColor;

+ (DDModalThemeConfig *)sharedConfig;

@end
