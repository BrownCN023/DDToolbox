//
//  DDAsyncOperation.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/3/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDAsyncOperation;

typedef void (^DDAsyncOperationBlock)(DDAsyncOperation *operation);

//异步操作
@interface DDAsyncOperation : NSOperation

- (instancetype)initWithBlock:(DDAsyncOperationBlock)block;

//调用此方法完成操作(改变线程状态)
- (void)finishOperation;

@end
