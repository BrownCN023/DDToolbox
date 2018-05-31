//
//  NSObject+DDCopyProperties.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/22.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "NSObject+DDCopyProperties.h"
#import <objc/runtime.h>

@implementation NSObject (DDCopyProperties)

+ (void)cp_classInfoWithCls:(Class)cls cls_arr:(NSMutableArray *)cls_arr{
    
    NSString * className = NSStringFromClass(cls);
    [cls_arr addObject:className];
    
    NSString * superClassName = NSStringFromClass([cls superclass]);
    if(![superClassName isEqualToString:@"NSObject"]){
        [self cp_classInfoWithCls:class_getSuperclass(cls) cls_arr:cls_arr];
    }
}

+ (NSArray *)cp_getAllPropertiesWithCls:(Class)cls{
    u_int count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++){
        const char* propertyName = property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

- (void)copyProperties:(NSObject *)object{
    NSMutableArray * classes = [NSMutableArray new];
    [[self class] cp_classInfoWithCls:[self class] cls_arr:classes];
    
    for(NSString * className in classes){
        NSArray * ppties = [[self class] cp_getAllPropertiesWithCls:NSClassFromString(className)];
        for(NSString * pName in ppties){
            if([object respondsToSelector:NSSelectorFromString(pName)]){
                [self setValue:[object valueForKey:pName] forKeyPath:pName];
            }
        }
    }
}

@end
