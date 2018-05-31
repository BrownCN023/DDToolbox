//
//  NSUserDefaults+DDHelper.h
//  TTTDemo
//
//  Created by Brown on 2017/7/19.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (DDHelper)

+ (BOOL)saveObj:(id)obj forKey:(NSString *)key;
+ (id)readObjForKey:(NSString *)key;

+ (BOOL)saveVal:(id)val forKey:(NSString *)key;
+ (id)readValForKey:(NSString *)key;

+ (BOOL)saveBool:(BOOL)b key:(NSString *)key;
+ (BOOL)readBoolForKey:(NSString *)key;

+ (BOOL)saveInteger:(NSInteger)itg key:(NSString *)key;
+ (NSInteger)readIntegerForKey:(NSString *)key;

+ (BOOL)saveFloat:(float)f key:(NSString *)key;
+ (float)readFloatForKey:(NSString *)key;

+ (BOOL)saveDouble:(double)d key:(NSString *)key;
+ (double)readDoubleForKey:(NSString *)key;

@end
