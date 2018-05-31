//
//  DDTimer.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/1/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

//定时器
@interface DDTimer : NSObject

@property (atomic,assign,readonly) BOOL isStarting;

/**
 初始化定时器
 
 @param delayTime 首次延迟时间
 @param intervalTime 间隔时间
 @param handler 处理
 @return return
 */
- (instancetype)initWithDelayTime:(CGFloat)delayTime intervalTime:(CGFloat)intervalTime handler:(void (^)(void))handler;

//启动定时器
- (void)start;
//停止定时器
- (void)stop;

@end
