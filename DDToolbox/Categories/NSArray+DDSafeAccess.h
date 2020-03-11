//
//  NSMutableArray+DDSafeAccess.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/21.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DDSafeAccess)

- (id)safeObjectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (DDSafeAccess)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (void)safeAddObject:(id)obj;

- (void)safeRemoveObject:(id)obj;

- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index;

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)safeExchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

@end
