//
//  DDToolboxThemeConfig.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDToolboxThemeConfig.h"

int themeColor1 = 0xFF2742;
int themeColor2 = 0x36ab60;
int themeColor3 = 0x725dd1;
int themeColor4 = 0x37c6c0;
int themeColor5 = 0x373e40;

@implementation DDToolboxThemeConfig

+ (DDToolboxThemeConfig *)sharedConfig{
    static DDToolboxThemeConfig * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DDToolboxThemeConfig alloc] init];
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
    self.themeColor = DD_COLOR_Hex(themeColor5);
    self.titleColor = [UIColor whiteColor];
    self.messageColor = [UIColor darkGrayColor];
}

@end
