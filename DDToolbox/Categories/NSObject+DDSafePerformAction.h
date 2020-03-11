//
//  NSObject+DDSafePerformAction.h
//  DDMobDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DDSafePerformAction)

- (id)safePerformAction:(NSString *)action params:(NSArray *)params;
+ (id)safePerformAction:(NSString *)action target:(NSObject *)target params:(NSArray *)params;

@end

NS_ASSUME_NONNULL_END
