//
//  NSObject+DDSafeObserver.h
//  DDToolboxDemo
//
//  Created by abiaoyo on 2019/12/11.
//  Copyright © 2019 gensee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 安全KVO，可不手动移除KVO
 */
@interface NSObject (DDSafeObserver)

- (void)addSafeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options;

- (void)removeSafeObserver:(NSObject *)observer
                      forKeyPath:(NSString *)keyPath;

- (void)removeSafeAllObserver;

@end

NS_ASSUME_NONNULL_END
