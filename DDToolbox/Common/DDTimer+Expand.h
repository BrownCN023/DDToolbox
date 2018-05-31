//
//  DDTimer+Expand.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/1/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTimer.h"

@interface DDTimer (Expand)

/**
 延迟处理
 
 @param delayTime 时间
 @param queue 队列
 @param handler 处理
 */
+ (void)delayMethod:(CGFloat)delayTime queue:(dispatch_queue_t)queue handler:(void (^)(void))handler;

/**
 延迟处理
 
 @param delayTime 时间
 @param handler 处理
 */
+ (void)delayMethodOnMainQueue:(CGFloat)delayTime handler:(void (^)(void))handler;

/**
 延迟处理
 
 @param delayTime 时间
 @param handler 处理
 */
+ (void)delayMethodOnGlobalDefaultQueue:(CGFloat)delayTime handler:(void (^)(void))handler;

@end
