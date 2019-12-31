//
//  NSObject+DDFastHelper.m
//  ABMob
//
//  Created by abiaoyo on 2019/11/22.
//  Copyright © 2019 abiang. All rights reserved.
//

#import "NSObject+DDFastHelper.h"

@implementation NSObject (DDFastHelper)

+ (void)fastPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(!viewController){
        return;
    }
    [[self _getCurrentNavigationController] pushViewController:viewController animated:animated];
}

+ (void)fastPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion{
    [[self _getCurrentPresentedViewController] presentViewController:viewController animated:animated completion:completion];
}

+ (id)fastPerformAction:(NSString *)action target:(NSObject *)target params:(id)params
{
    if(!action){
        return nil;
    }
    if(!target){
        return nil;
    }
    SEL _action = NSSelectorFromString(action);
    if(![target respondsToSelector:_action]){
        return nil;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:_action withObject:params];
#pragma clang diagnostic pop
}

+ (id)fastPerformAction:(NSString *)action className:(NSString *)className params:(id)params{
    if(!action){
        return nil;
    }
    SEL _action = NSSelectorFromString(action);

    Class _class = NSClassFromString(className);
    if(![_class respondsToSelector:_action]){
        return nil;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [_class performSelector:_action withObject:params];
#pragma clang diagnostic pop
}


//+ (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params
//{
//    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
//    if(methodSig == nil) {
//        return nil;
//    }
//    const char* retType = [methodSig methodReturnType];
//
//    if (strcmp(retType, @encode(void)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        return nil;
//    }
//
//    if (strcmp(retType, @encode(NSInteger)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        NSInteger result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(BOOL)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        BOOL result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(CGFloat)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        CGFloat result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//    if (strcmp(retType, @encode(NSUInteger)) == 0) {
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//        [invocation setArgument:&params atIndex:2];
//        [invocation setSelector:action];
//        [invocation setTarget:target];
//        [invocation invoke];
//        NSUInteger result = 0;
//        [invocation getReturnValue:&result];
//        return @(result);
//    }
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    return [target performSelector:action withObject:params];
//#pragma clang diagnostic pop
//}


+ (UINavigationController *)_getCurrentNavigationController
{
    UIViewController * viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if([viewController isKindOfClass:[UINavigationController class]]){
        return (UINavigationController *)viewController;
    }
    if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabBarController = (UITabBarController *)viewController;
        UIViewController * selectedViewController = tabBarController.selectedViewController;
        if([selectedViewController isKindOfClass:[UINavigationController class]]){
            return (UINavigationController *)selectedViewController;
        }
    }
    return nil;
}

- (UIViewController *)_getCurrentPresentedViewController{
    UIViewController * viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

@end
