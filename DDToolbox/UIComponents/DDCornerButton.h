//
//  DDCornerButton.h
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/18.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DDCornerButton : UIButton

@property (nonatomic,assign) IBInspectable CGSize cornerSize;
@property (nonatomic,assign) UIRectCorner corners;

@end
