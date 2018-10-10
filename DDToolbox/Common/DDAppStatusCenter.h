//
//  DDAppStatusCenter.h
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDAppStatusCenterDelegate <NSObject>

@optional
- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DDAppStatusCenter : NSObject

+ (DDAppStatusCenter *)sharedInstance;
- (void)addDelegate:(id<DDAppStatusCenterDelegate>)delegate;
- (void)removeDelegate:(id<DDAppStatusCenterDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
