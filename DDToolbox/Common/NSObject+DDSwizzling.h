//
//  NSObject+Swizzling.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/21.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDSwizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
