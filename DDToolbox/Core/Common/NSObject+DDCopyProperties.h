//
//  NSObject+DDCopyProperties.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/22.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDCopyProperties)


/**
 *  属性拷贝
 *  将object中与self的相同的属性拷贝到self
 *  @param object 
 */
- (void)copyProperties:(NSObject *)object;

@end
