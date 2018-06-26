//
//  DDWeakDelegateObject.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/21.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDWeakDelegateObject.h"

@interface DDWeakDelegateObject(){
    NSHashTable * _delegates;
}
@end

@implementation DDWeakDelegateObject

- (instancetype)init{
    self = [super init];
    if (self) {
        _delegates = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (NSArray *)allDelegates{
    return _delegates.allObjects;
}

- (void)addDelegate:(id)delegate{
    [_delegates addObject:delegate];
}

- (void)removeDelegate:(id)delegate{
    [_delegates removeObject:delegate];
}
@end
