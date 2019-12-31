//
//  NSObject+DDSafeObserver.m
//  DDToolboxDemo
//
//  Created by abiaoyo on 2019/12/11.
//  Copyright © 2019 gensee. All rights reserved.
//

#import "NSObject+DDSafeObserver.h"
#import <objc/runtime.h>

#define kDDSafeObserverObject @"kDDSafeObserverObject"

@interface DDSafeObserverObject : NSObject
@property (nonatomic,unsafe_unretained) id target;
@property (nonatomic,strong) NSMutableDictionary<NSString *, NSHashTable *> * allObserver;
@end

@implementation DDSafeObserverObject

- (void)dealloc{
    NSLog(@"--- dealloc %@ ---",self.class);
    [self safeRemoveAllObserver];
    [self.allObserver removeAllObjects];
    self.target = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allObserver = [NSMutableDictionary new];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    NSHashTable * obsersers = [self.allObserver valueForKey:keyPath];
    if(obsersers){
        [obsersers.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj && [obj respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]){
                [obj observeValueForKeyPath:keyPath
                                   ofObject:object
                                     change:change
                                    context:context];
            }
        }];
    }
}

- (void)safeAddObserver:(NSObject *)observer
                  forKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
{
    NSHashTable * observers = [self.allObserver valueForKey:keyPath];
    
    if(!observers){
        observers = [NSHashTable weakObjectsHashTable];
        [self.allObserver setValue:observers forKey:keyPath];
        [self.target addObserver:self
                      forKeyPath:keyPath
                         options:NSKeyValueObservingOptionNew
                         context:kDDSafeObserverObject];
    }
    
    if(![observers containsObject:observer]){
        [observers addObject:observer];
    }
}

- (void)safeRemoveObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath
{
    NSHashTable * observers = [self.allObserver valueForKey:keyPath];
    if([observers containsObject:observer]){
        [observers removeObject:observer];
    }
}

- (void)safeRemoveAllObserver{
    for(NSString * keyPath in self.allObserver.allKeys){
        [self.target removeObserver:self forKeyPath:keyPath context:kDDSafeObserverObject];
        NSLog(@"%s | keyPath:%@ | target:%@",__func__,keyPath,self.target);
    }
    [self.allObserver removeAllObjects];
}

@end

@implementation NSObject (DDSafeObserver)

- (DDSafeObserverObject *)safeObserver{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSafeObserver:(DDSafeObserverObject *)safeObserver{
    objc_setAssociatedObject(self, @selector(safeObserver), safeObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DDSafeObserverObject *)currentSafeObserver{
    DDSafeObserverObject * safeObserver = [self safeObserver];
    if(!safeObserver){
        safeObserver = [DDSafeObserverObject new];
        safeObserver.target = self;
        [self setSafeObserver:safeObserver];
    }
    return safeObserver;
}

- (void)addSafeObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
{
    DDSafeObserverObject * safeObserver = [self currentSafeObserver];
    [safeObserver safeAddObserver:observer forKeyPath:keyPath options:options];
}

- (void)removeSafeObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath
{
    DDSafeObserverObject * safeObserver = [self currentSafeObserver];
    [safeObserver safeRemoveObserver:observer forKeyPath:keyPath];
}

- (void)removeSafeAllObserver
{
    DDSafeObserverObject * safeObserver = [self currentSafeObserver];
    [safeObserver safeRemoveAllObserver];
}

@end
