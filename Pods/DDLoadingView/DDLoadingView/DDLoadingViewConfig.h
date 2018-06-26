//
//  DDLoadingViewConfig.h
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLoadingViewConfig : NSObject

@property (nonatomic,strong) UIColor * backgroundColor;
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIColor * subTitleColor;
@property (nonatomic,strong) UIColor * trackColor;
@property (nonatomic,assign) NSInteger trackLineWidth;
@property (nonatomic,assign) NSInteger trackLineRadius;

@property (nonatomic,copy) NSString * failedTitle;
@property (nonatomic,copy) NSString * failedSubTitle;
@property (nonatomic,copy) NSString * noDataTitle;
@property (nonatomic,copy) NSString * noDataSubTitle;
@property (nonatomic,copy) NSString * errorTitle;
@property (nonatomic,copy) NSString * errorSubTitle;

@end
