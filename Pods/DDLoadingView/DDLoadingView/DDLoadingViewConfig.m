//
//  DDLoadingViewConfig.m
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDLoadingViewConfig.h"

@implementation DDLoadingViewConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleColor = [UIColor darkTextColor];
        self.subTitleColor = [UIColor lightGrayColor];
        self.trackColor = [UIColor colorWithRed:54/255.0 green:171/255.0 blue:96/255.0 alpha:1.0];
        self.trackLineWidth = 2.0f;
        self.trackLineRadius = 12.0f;

        self.failedTitle = @"加载失败";
        self.failedSubTitle = @"点击空白处刷新";
        self.errorTitle = @"数据错误";
        self.errorSubTitle = @"点击空白处刷新";
        self.noDataTitle = @"暂无数据";
        self.noDataSubTitle = @"";
    }
    return self;
}

@end
