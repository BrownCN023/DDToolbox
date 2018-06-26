//
//  AppDelegate.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "AppDelegate.h"
#import "DDWeakDelegateObject.h"
#import "NSArray+DDSafeAccess.h"
@interface AppDelegate (){
    NSMutableSet * delegates;
    NSMutableArray * delegateArray;
    NSHashTable * hashTable;
    NSPointerArray * _weakPointerArray;
    DDWeakDelegateObject * mDelegates;
}

@property (nonatomic,strong) NSMutableArray * testArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    NSMutableArray * arr = [NSMutableArray new];
    
    NSString * str2 = nil;// [NSNull null];
    [arr safeAddObject:str2];
    id obj = [arr safeObjectAtIndex:0];
    
    NSLog(@"arr:%@     obj:%@",arr,obj);
    
    mDelegates = [[DDWeakDelegateObject alloc] init];
    
    @autoreleasepool {
        DDWeakDelegateObject * obj = [[DDWeakDelegateObject alloc] init];
        [mDelegates addDelegate:obj];
        NSLog(@"mDelegates allObjects:%@",mDelegates.allDelegates);
    }
    
    NSMutableString * str = [[NSMutableString alloc] init];
    [str appendString:@"sdfsdf"];
//    NSString *str = [NSString stringWithFormat:@"Hello! %@",@"Cat"];
    [mDelegates addDelegate:str];
//    str = nil;
    NSLog(@"mDelegates allObjects:%@",mDelegates.allDelegates);
    
    [mDelegates addDelegate:self];
    NSLog(@"mDelegates allObjects:%@",mDelegates.allDelegates);
    
    [mDelegates addDelegate:self];
    NSLog(@"mDelegates allObjects:%@",mDelegates.allDelegates);
    
//    //初始化一个弱引用数组对象
//    _weakPointerArray = [NSPointerArray weakObjectsPointerArray];
//    for(int i=0;i<10;i++){
//        NSObject *obj = [NSObject new];
//        //往数组中添加对象
//        [_weakPointerArray addPointer:(__bridge void * _Nullable)(obj)];
//    }
//    //输出数组中的所有对象,如果没有对象会输出一个空数组
//    NSArray *array = [_weakPointerArray allObjects];
//    NSLog(@"%@",array);
//    //输出数组中的元素个数,包括NULL
//    NSLog(@"%zd",_weakPointerArray.count);//此时输出:10,因为NSObject在for循环之后就被释放了
//    //先数组中添加一个NULL
//    [_weakPointerArray addPointer:NULL];
//    NSLog(@"%zd",_weakPointerArray.count);//输出:11
//    //清空数组中的所有NULL,注意:经过测试如果直接compact是无法清空NULL,需要在compact之前,调用一次[_weakPointerArray addPointer:NULL],才可以清空
//    [_weakPointerArray compact];
//    NSLog(@"%zd",_weakPointerArray.count);//输出:0
//    //注意:如果直接往_weakPointerArray中添加对象,那么addPointer方法执行完毕之后,NSObject会直接被释放掉
//    [_weakPointerArray addPointer:(__bridge void * _Nullable)([NSObject new])];
//    NSLog(@"%@",[_weakPointerArray allObjects]);//输出:空数组 NSPointArray[7633:454561] ()
//    //应该这样添加对象
//    NSObject *obj = [NSObject new];
//    [_weakPointerArray addPointer:(__bridge void * _Nullable)obj];
//    NSLog(@"%@",[_weakPointerArray allObjects]);//输出:NSPointArray[7633:454561] ("<NSObject: 0x6000000078c0>")
    /*
     同样的:NSMapTable对应NSDictionary,NSHashTable对应NSSet
     */
    
    
//    delegates = [NSMutableSet set];
//    delegateArray = [NSMutableArray new];
//    hashTable = [NSHashTable weakObjectsHashTable];
//    self.testArray = [NSMutableArray new];
//    [self.testArray addObject:@"QWE22DD"];
//
//    [hashTable addObject:self.testArray];
//    NSLog(@"hashTable:%@  obj:%@",@(hashTable.count),[hashTable allObjects]);
//    self.testArray = nil;
//    NSLog(@"hashTable:%@  obj:%@",@(hashTable.count),[hashTable allObjects]);
    
//    DDWeakDelegate * d1 = [[DDWeakDelegate alloc] initWithDelegate:self];
//    [delegates addObject:d1];
//    [delegateArray addObject:d1];
//    NSLog(@"delegates1:%@     arr:%@",delegates,delegateArray);
//
//
//    DDWeakDelegate * d2 = [[DDWeakDelegate alloc] initWithDelegate:self];
//    [delegates addObject:d2];
//    [delegateArray addObject:d2];
//    NSLog(@"delegates2:%@     arr:%@",delegates,delegateArray);
//
//    NSLog(@"d1:%@ d2:%@",d1,d2);
//
//    NSLog(@"d1==d2:%d   d1 isEq d2:%d",d1==d2,[d1 isEqual:d2]);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
