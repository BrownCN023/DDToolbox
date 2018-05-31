//
//  DDAsyncOperation.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/3/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDAsyncOperation.h"

@interface DDAsyncOperation()

@property (nonatomic,assign) BOOL dd_executing;
@property (nonatomic,assign) BOOL dd_finished;
@property (nonatomic,copy) DDAsyncOperationBlock block;

@end

@implementation DDAsyncOperation

- (instancetype)initWithBlock:(DDAsyncOperationBlock)block{
    if(self = [super init]){
        self.block = block;
    }
    return self;
}

- (void)start{
    if(self.cancelled){
        _dd_finished = YES;
        return;
    }
    _dd_executing = YES;
    if(self.block){
        self.block(self);
    }
}

- (void)finishOperation{
    self.dd_executing = NO;
    self.dd_finished = YES;
}

- (void)setDd_executing:(BOOL)dd_executing{
    [self willChangeValueForKey:@"isExecuting"];
    _dd_executing = dd_executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setDd_finished:(BOOL)dd_finished{
    [self willChangeValueForKey:@"isFinished"];
    _dd_finished = dd_finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished{
    return _dd_finished;
}

- (BOOL)isExecuting{
    return _dd_executing;
}

- (BOOL)isAsynchronous{
    return YES;
}

- (BOOL)isConcurrent{
    return YES;
}

@end
