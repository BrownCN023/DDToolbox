//
//  NSObject+DDFastHelper.h
//  ABMob
//
//  Created by abiaoyo on 2019/11/22.
//  Copyright © 2019 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DDFastHelper)
+ (void)fastPushViewController:(UIViewController *)viewController
                      animated:(BOOL)animated;

+ (void)fastPresentViewController:(UIViewController *)viewController
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion;

+ (id)fastPerformAction:(NSString *)action
                 target:(NSObject *)target
                 params:(id)params;

+ (id)fastPerformAction:(NSString *)action
              className:(NSString *)className
                 params:(id)params;

@end

NS_ASSUME_NONNULL_END
