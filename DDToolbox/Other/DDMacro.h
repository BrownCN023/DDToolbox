//
//  DDMacro.h
//  DDTooboxDemo
//
//  Created by abiang on 2017/7/19.
//  Copyright © 2017年 Brown. All rights reserved.
//

#ifndef DDMacro_h
#define DDMacro_h

#import <UIKit/UIKit.h>

//************* DEBUG 模式下打印日志,换行 **************
#ifdef DEBUG
#define DDNLog(...) NSLog(@"%s 第%d行 \n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DDNLog(...)
#endif

//************* DEBUG 模式下打印日志,没有时间等信息 **************
#ifdef DEBUG
#define DDPLog(format, ...) printf("-- 🍄 %s:(%d) --   %s\n\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DDPLog(format, ...)
#endif

//*************** Weak | Strong ****************
#define DDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define DDStrongSelf(type) __strong typeof(type) type = weak##type;

//*************** Color *****************
#define DD_COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DD_COLOR_RGB(r,g,b) DD_COLOR_RGBA(r,g,b,1.0)
#define DD_COLOR_RandomA(a) DD_COLOR_RGBA(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),a)
#define DD_COLOR_Random() DD_COLOR_RandomA(1.0)
#define DD_COLOR_HexA(hex,a) DD_COLOR_RGBA(((hex & 0xFF0000) >> 16),((hex &0xFF00) >>8),(hex &0xFF),a)
#define DD_COLOR_Hex(hex) DD_COLOR_HexA(hex,1.0)
#define DD_Color_Clear [UIColor clearColor]

//*************** 角度 | 弧度 ****************
#define DD_DegreesToRadian(x) (M_PI * (x) / 180.0)       //角度转弧度
#define DD_RadianToDegrees(radian) (radian*180.0)/(M_PI) //弧度转角度

//*************** 图片加载 *****************
#define DD_ImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]   //获取图片
#define DD_ImageLoad(path) [UIImage imageWithData:[NSData dataWithContentsOfFile:path]]

//*************** 系统属性 ******************
#define DD_Language ([[NSLocale preferredLanguages] objectAtIndex:0])   //获取当前语言
#define DD_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)  //判断是否iPhone
#define DD_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  //判断是否iPad
#define DD_IOS_VERSION [[UIDevice currentDevice] systemVersion]  //系统版本号
#define DD_IOS_VERSION_8_OR_LATER (([DD_IOS_VERSION floatValue] >=8.0)? (YES):(NO))  //iOS8或更高版本
#define DD_IOS_VERSION_11_OR_LATER (([DD_IOS_VERSION floatValue] >=11.0)? (YES):(NO))  //iOS8或更高版本
#define DD_IS_IOS (TARGET_OS_IPHONE)   //是否iOS系统
#define DD_IS_SIMULATOR (TARGET_IPHONE_SIMULATOR)   //是否模拟器
#define DD_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  //APP版本号

//****************** GCD ********************
#define DD_GCD_Global_Sync(block)\
dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define DD_GCD_Global_Async(block)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define DD_GCD_Main_SyncSafe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define DD_GCD_Main_AsyncSafe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//*************** 空值判断 *****************
#define DD_StringIsEmpty(str) (str == nil || [str isKindOfClass:[NSNull class]] || ([str isKindOfClass:[NSString class]] && (str.length < 1 ? YES : NO )))
#define DD_StringIsEmpty_Ex(str,defValue) (DD_StringIsEmpty(str)?defValue:str)

#define DD_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || ([array isKindOfClass:[NSArray class]] && (array.count == 0)))
#define DD_ArrayIsEmpty_Ex(array,defValue) (DD_ArrayIsEmpty(array)?defValue:array)

#define DD_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || ([dic isKindOfClass:[NSDictionary class]] && (dic.allKeys == 0)))
#define DD_DictIsEmpty_Ex(dic,defValue) (DD_DictIsEmpty(dic)?defValue:dic)

#define DD_ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//去掉前后空格
#define DD_StringTrim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

//*************** 尺寸相关 *****************
#define DD_ScreenSize [UIScreen mainScreen].bounds.size
#define DD_ScreenWidth DD_ScreenSize.width
#define DD_ScreenHeight DD_ScreenSize.height

#define DD_DeviceSizeEqualToSize(toSize) ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(toSize, [[UIScreen mainScreen] currentMode].size) : NO)

#define DD_IS_IPHONE_4 DD_DeviceSizeEqualToSize(CGSizeMake(640,960))
#define DD_IS_IPHONE_5 DD_DeviceSizeEqualToSize(CGSizeMake(640,1136))
#define DD_IS_IPHONE_6 DD_DeviceSizeEqualToSize(CGSizeMake(750,1334))
#define DD_IS_IPHONE_6Plus DD_DeviceSizeEqualToSize(CGSizeMake(1242,2208))
#define DD_IS_IPHONE_X DD_DeviceSizeEqualToSize(CGSizeMake(1125,2436))
#define DD_IS_IPHONE_Xr DD_DeviceSizeEqualToSize(CGSizeMake(828,1792))
#define DD_IS_IPHONE_Xs_Max DD_DeviceSizeEqualToSize(CGSizeMake(1242,2688))

#define DD_IS_IPHONE_X_TYPE (DD_IS_IPHONE_X || DD_IS_IPHONE_Xr || DD_IS_IPHONE_Xs_Max)

#define DD_StatusBarHeight (DD_IS_IPHONE_X_TYPE ? 44.0 : 20.0)
#define DD_NavigationBarHeight (DD_IS_IPHONE_X_TYPE ? 88.0f : 64.0f)
#define DD_TabBarHeight (DD_IS_IPHONE_X_TYPE ? 83.0 : 49.0)

#define  DD_adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

//****************** 常用宏 ********************
#define DD_Application        [UIApplication sharedApplication]
#define DD_KeyWindow          [UIApplication sharedApplication].keyWindow
#define DD_AppDelegate        [UIApplication sharedApplication].delegate
#define DD_UserDefaults       [NSUserDefaults standardUserDefaults]
#define DD_NotificationCenter [NSNotificationCenter defaultCenter]

#endif /* DDMacro_h */
