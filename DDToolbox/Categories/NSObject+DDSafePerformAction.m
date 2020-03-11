//
//  NSObject+DDSafePerformAction.m
//  DDMobDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//  github: https://github.com/dsxNiubility/WMScheduler  WMSchedulerCore
//

#import "NSObject+DDSafePerformAction.h"

@implementation NSObject (DDSafePerformAction)

- (id)safePerformAction:(NSString *)action params:(NSArray *)params
{
    return [NSObject dd_safePerformAction:action target:self params:params];
}

+ (id)safePerformAction:(NSString *)action target:(NSObject *)target params:(NSArray *)params
{
    return [NSObject dd_safePerformAction:action target:target params:params];
}

#define CompareTypeAndReturn(type) \
if (strcmp(retType, @encode(type)) == 0) {\
type result = 0;\
[invocation getReturnValue:&result];\
return @(result);\
}

#define CreateNSError(errorCode,errorMessage) [NSError errorWithDomain:NSCocoaErrorDomain code:errorCode userInfo:@{@"message":errorMessage}]

+ (id)dd_safePerformAction:(NSString *)action
                    target:(NSObject *)target
                    params:(NSArray *)params
{
    if(!action){
        return CreateNSError(12001,@"请传入一个非空的选择器");
    }
    SEL _action = NSSelectorFromString(action);
    if (NULL == _action) {
        return CreateNSError(12001,@"请传入一个非空的选择器");
    }
    
    if(!target){
        return CreateNSError(12002,@"请传入一个非空的对象");
    }
    
    if(![target respondsToSelector:_action]){
        return CreateNSError(12003,@"未被实现的方法");
    }
    
    NSMethodSignature* methodSig = [target methodSignatureForSelector:_action];
    if(methodSig == nil) {
        return CreateNSError(12004,@"未取到方法签名");
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == [NSNull null]) {
            obj = nil;
        } // 外部传[NSNull null]来代替nil，用于你想给谁set nil的需求
        if(obj){
            [invocation setArgument:&obj atIndex:(idx+2)];
        }
    }];
    [invocation setSelector:_action];
    [invocation setTarget:target];
    [invocation invoke];
    
    const char* retType = [methodSig methodReturnType];
    if (strcmp(retType, @encode(void)) == 0) {
        return nil;
    }
    // 返回值类型为基本数据类型的处理（包装成NSNumber返回）
    if (strcmp(retType, @encode(int)) == 0) {
        int result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    CompareTypeAndReturn(NSInteger)
    CompareTypeAndReturn(NSUInteger)
    CompareTypeAndReturn(CGFloat)
    CompareTypeAndReturn(char)
    CompareTypeAndReturn(short)
    CompareTypeAndReturn(float)
    CompareTypeAndReturn(double)
    CompareTypeAndReturn(long long)
    CompareTypeAndReturn(BOOL)
    CompareTypeAndReturn(unsigned char)
    CompareTypeAndReturn(unsigned short)
    CompareTypeAndReturn(unsigned long long)
    
    // 返回值为Class类型
    if (strcmp(retType, @encode(Class)) == 0) {
        __autoreleasing Class class = nil;
        [invocation getReturnValue:&class];
        return class;
    }
    // 能到这里的id，就是参数数量多于2个的
    if (strcmp(retType, @encode(id)) == 0) {
        __autoreleasing id obj = nil;
        [invocation getReturnValue:&obj];
        return obj;
    }
    
    // 再然后剩下的返回类型就剩下 结构体、联合体、c数组、选择子 等少见类型了
    NSString *returnErrorStr = [NSString stringWithFormat:@"该方法返回值类型不支持，类型为%s",retType];
    return CreateNSError(12005,returnErrorStr);
}

@end
