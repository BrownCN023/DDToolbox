//
//  DDGridLayoutView.h
//  iOSDDMao
//
//  Created by TongAn001 on 2018/7/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGridSimpleLayoutView : UIView

@property (nonatomic,assign) NSUInteger rows;  //行
@property (nonatomic,assign) NSUInteger columns;  //列

- (void)addGridSubview:(UIView *)view;
- (void)removeGridSubview:(UIView *)view;
- (void)removeAllGrideSubview;

@end
