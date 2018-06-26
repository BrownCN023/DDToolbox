//
//  NSMutableString+DDNode.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "NSMutableString+DDNode.h"

@implementation NSMutableString (DDNode)

- (DDMutableStringAppendExpNode)appendNode{
    return ^(BOOL exp,DDMutableStringAppendNodeCallback callback){
        if(exp){
            if(callback){
                NSString * _obj = callback();
                [self appendString:_obj];
            }
        }
        return self;
    };
}

@end
