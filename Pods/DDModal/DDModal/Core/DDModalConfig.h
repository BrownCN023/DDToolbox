//
//  DDModalConfig.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/5/31.
//  Copyright © 2018年 abiang. All rights reserved.
//

#ifndef DDModalConfig_h
#define DDModalConfig_h

#import <UIKit/UIKit.h>

//*************** Color *****************
#define DDModal_COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DDModal_COLOR_RGB(r,g,b) DDModal_COLOR_RGBA(r,g,b,1.0)
#define DDModal_COLOR_HexA(hex,a) DDModal_COLOR_RGBA(((hex & 0xFF0000) >> 16),((hex &0xFF00) >>8),(hex &0xFF),a)
#define DDModal_COLOR_Hex(hex) DDModal_COLOR_HexA(hex,1.0)

#define DDModal_COLOR_RandomA(a) DDModal_COLOR_RGBA(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),a)
#define DDModal_COLOR_Random() DDModal_COLOR_RandomA(1.0)

#define DDModal_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define DDModal_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define DDModal_ScreenSize [UIScreen mainScreen].bounds.size
#define DDModal_ScreenWidth DDModal_ScreenSize.width
#define DDModal_ScreenHeight DDModal_ScreenSize.height

#endif /* DDModalConfig_h */
