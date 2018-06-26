//
//  NSMutableArray+DDSafeAccess.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/21.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "NSArray+DDSafeAccess.h"
#import "DDMacro.h"

@implementation NSArray (DDSafeAccess)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        DDFLog(@"can't get any object from an empty array");
        return nil;
    }
    if (index > self.count) {
        DDFLog(@"index out of bounds in array");
        return nil;
    }
    return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (DDSafeAccess)

- (void)safeAddObject:(id)obj{
    if(nil == obj){
        DDFLog(@"obj is nil");
        return;
    }
    [self addObject:obj];
}

- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        DDFLog(@"obj is nil");
        return;
    }
    [self removeObject:obj];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        DDFLog(@"can't get any object from an empty array");
        return;
    }
    if (index >= self.count) {
        DDFLog(@"index out of bound");
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index {
    if (obj == nil) {
        DDFLog(@"can't insert nil into NSMutableArray");
        return;
    }
    if (index > self.count) {
        DDFLog(@"index is invalid");
        return;
    }
    [self insertObject:obj atIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if(self.count <= index){
        DDFLog(@"index out of bound");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)safeExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2{
    if(self.count <= idx1 || self.count <= idx2){
       DDFLog(@"index out of bound");
        return;
    }
    [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

@end
