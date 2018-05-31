//
//  NSMutableArray+DDNode.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "NSMutableArray+DDNode.h"

@implementation NSMutableArray (DDNode)
- (void)dd_append:(id)obj{
    if([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSMutableArray class]]){
        [self addObjectsFromArray:obj];
    }else{
        [self addObject:obj];
    }
}
- (DDMutableArrayAppendExpNode)appendNode{
    return ^(BOOL exp,DDMutableArrayAppendNodeCallback callback){
        if(exp){
            if(callback){
                id _obj = callback();
                [self dd_append:_obj];
            }
        }
        return self;
    };
}
@end
