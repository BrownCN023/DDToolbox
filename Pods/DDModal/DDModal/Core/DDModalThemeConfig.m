//
//  DDModalThemeConfig.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalThemeConfig.h"

int modalThemeColor1 = 0xFF2742;
int modalThemeColor2 = 0x36ab60;
int modalThemeColor3 = 0x725dd1;
int modalThemeColor4 = 0x37c6c0;
int modalThemeColor5 = 0x373e40;

@implementation DDModalThemeConfig

+ (DDModalThemeConfig *)sharedConfig{
    static DDModalThemeConfig * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DDModalThemeConfig alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _setupData];
    }
    return self;
}

- (void)_setupData{
    self.themeColor = DDModal_COLOR_Hex(modalThemeColor5);
    self.titleColor = [UIColor whiteColor];
    self.messageColor = [UIColor blackColor];
    self.tintColor = DDModal_COLOR_RGB(40, 126, 245);//[UIColor darkGrayColor];
}

@end
