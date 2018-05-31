//
//  DDTimer.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/1/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTimer.h"

@interface DDTimer(){
    dispatch_source_t customTimer;
}

@property (nonatomic,assign) CGFloat delayTime;
@property (nonatomic,assign) CGFloat intervalTime;
@property (nonatomic,copy) void (^handler)(void);
@property (atomic,assign) BOOL isStarting;

@end

@implementation DDTimer

- (instancetype)initWithDelayTime:(CGFloat)delayTime intervalTime:(CGFloat)intervalTime handler:(void (^)(void))handler{
    self = [super init];
    if (self) {
        self.delayTime = delayTime;
        self.intervalTime = intervalTime;
        self.handler = handler;
    }
    return self;
}

- (void)start{
    if(self.isStarting){
        return;
    }
    [self stop];
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_queue_create("ddboxtool.ddtimer", DISPATCH_QUEUE_CONCURRENT);
    customTimer = [DDTimer createTimerWithStartTime:self.delayTime intervalTime:self.intervalTime queue:queue handler:self.handler];
    if(!customTimer){
        NSLog(@"创建定时器失败");
        return;
    }
    self.isStarting = YES;
}

- (void)stop{
    if(customTimer){
        dispatch_cancel(customTimer);
        customTimer = nil;
    }
    self.isStarting = NO;
}


+ (dispatch_source_t)createTimerWithStartTime:(CGFloat)startTime intervalTime:(CGFloat)intervalTime queue:(dispatch_queue_t)queue handler:(void (^)(void))handler{
    if(startTime < 0.0f || intervalTime <= 0.0f || handler == nil){
        NSLog(@"创建定时器失败: delayTime < 0.0f || intervalTime <= 0.0f || handler == nil");
        return nil;
    }
    //创建一个定时器
    dispatch_source_t sourceTime = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(startTime * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(intervalTime* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(sourceTime, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(sourceTime, handler);
    //由于定时器默认是暂停的所以我们启动一下
    dispatch_resume(sourceTime);
    
    return sourceTime;
}

@end
