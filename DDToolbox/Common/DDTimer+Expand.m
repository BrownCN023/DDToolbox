//
//  DDTimer+Expand.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/1/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTimer+Expand.h"

@implementation DDTimer (Expand)

+ (void)delayMethod:(CGFloat)delayTime queue:(dispatch_queue_t)queue handler:(void (^)(void))handler{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
    dispatch_after(popTime, queue, handler);
}

+ (void)delayMethodOnMainQueue:(CGFloat)delayTime handler:(void (^)(void))handler{
    [self delayMethod:delayTime queue:dispatch_get_main_queue() handler:handler];
}

+ (void)delayMethodOnGlobalDefaultQueue:(CGFloat)delayTime handler:(void (^)(void))handler{
    [self delayMethod:delayTime queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) handler:handler];
}

@end
