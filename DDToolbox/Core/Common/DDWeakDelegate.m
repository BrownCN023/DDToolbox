//
//  DDWeakDelegate.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/3/28.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDWeakDelegate.h"

@implementation DDWeakDelegate

- (instancetype)initWithDelegate:(id)delegate{
    if(self = [super init]){
        _delegate = delegate;
    }
    return self;
}

- (BOOL)isEqualWeakDelegate:(DDWeakDelegate *)weakDelegate{
    if(!weakDelegate){
        return NO;
    }
    if(!self.delegate || !weakDelegate.delegate){
        return NO;
    }
    return [self.delegate isEqual:weakDelegate.delegate];
}

- (BOOL)isEqual:(id)object{
    if(self == object){
        return YES;
    }
    if(![object isKindOfClass:[DDWeakDelegate class]]){
        return NO;
    }
    return [self isEqualWeakDelegate:(DDWeakDelegate *)object];
}

- (NSUInteger)hash {
    if(self.delegate){
        return [self.delegate hash];
    }else{
        return [DDWeakDelegate hash];
    }
}

@end
