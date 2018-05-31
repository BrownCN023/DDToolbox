//
//  NSUserDefaults+DDHelper.m
//  TTTDemo
//
//  Created by Brown on 2017/7/19.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import "NSUserDefaults+DDHelper.h"

@implementation NSUserDefaults (DDHelper)

+ (BOOL)saveObj:(id)obj forKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:obj forKey:key];
    return [ud synchronize];
}

+ (id)readObjForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+ (BOOL)saveVal:(id)val forKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:val forKey:key];
    return [ud synchronize];
}

+ (id)readValForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud valueForKey:key];
}

+ (BOOL)saveBool:(BOOL)b key:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:b forKey:key];
    return [ud synchronize];
}

+ (BOOL)readBoolForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}

+ (BOOL)saveInteger:(NSInteger)itg key:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:itg forKey:key];
    return [ud synchronize];
}

+ (NSInteger)readIntegerForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud integerForKey:key];
}

+ (BOOL)saveFloat:(float)f key:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:f forKey:key];
    return [ud synchronize];
}

+ (float)readFloatForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud floatForKey:key];
}

+ (BOOL)saveDouble:(double)d key:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setDouble:d forKey:key];
    return [ud synchronize];
}

+ (double)readDoubleForKey:(NSString *)key
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud doubleForKey:key];
}

@end
