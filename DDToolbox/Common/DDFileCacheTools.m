//
//  DDFileCacheTools.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/4/16.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDFileCacheTools.h"
#import "DDMacro.h"

static NSString * DDFileCacheToolsSandboxPath(NSSearchPathDirectory searchPathDirectory){
    return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) firstObject];
}

@implementation DDFileCacheTools

+ (NSString *)cachePath{
    return DDFileCacheToolsSandboxPath(NSCachesDirectory);
}

+ (NSString *)getRealPathByFilePath:(NSString *)filePath{
    NSString * cachePath = [self cachePath];
    NSString * targetFilePath = [cachePath stringByAppendingPathComponent:filePath];
    return targetFilePath;
}

+ (NSInteger)createCachePaths:(NSArray<NSString *> *)paths{
    NSInteger errCount = 0;
    NSString * cachePath = [self cachePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    for(NSString * path in paths){
        BOOL isDir = NO;
        NSString * targetPath = [cachePath stringByAppendingPathComponent:path];
        BOOL isExists = [fileManager fileExistsAtPath:targetPath isDirectory:&isDir];
        if(!isExists){
            BOOL suc = [fileManager createDirectoryAtPath:targetPath withIntermediateDirectories:YES attributes:nil error:nil];
            if(!suc){
                errCount ++;
            }
        }
    }
    return errCount;
}

+ (BOOL)saveData:(NSData *)data filePath:(NSString *)filePath{
    NSString * realFilePath = [self getRealPathByFilePath:filePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL b = [self checkExistsByFilePath:realFilePath];
    BOOL hasError = NO;
    if(b){
        [self delByRealFilePath:realFilePath];
    }
    hasError = [fileManager createFileAtPath:realFilePath contents:data attributes:nil];
    return hasError;
}

+ (BOOL)moveFileByOriRealFilePath:(NSString *)oriRealFilePath targetRealFilePath:(NSString *)targetRealFilePath{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if([self checkExistsByRealFilePath:oriRealFilePath]){
        if([self checkExistsByRealFilePath:targetRealFilePath]){
            [self delByRealFilePath:targetRealFilePath];
        }
        return [fileManager moveItemAtPath:oriRealFilePath toPath:targetRealFilePath error:nil];
    }
    return NO;
}

+ (BOOL)checkExistsByFilePath:(NSString *)filePath{
    NSString * realFilePath = [self getRealPathByFilePath:filePath];
    return [self checkExistsByRealFilePath:realFilePath];
}

+ (BOOL)checkExistsByRealFilePath:(NSString *)realFilePath{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:realFilePath];
}

+ (void)checkExistsByFilePath:(NSString *)filePath completion:(void (^)(BOOL exists,BOOL isDir,NSString * filePath))completion{
    NSString * realFilePath = [self getRealPathByFilePath:filePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exists = [fileManager fileExistsAtPath:realFilePath isDirectory:&isDir];
    if(completion){
        completion(exists,isDir,realFilePath);
    }
}

+ (BOOL)delByFilePath:(NSString *)filePath{
    NSString * realFilePath = [self getRealPathByFilePath:filePath];
    return [self delByRealFilePath:realFilePath];
}

+ (BOOL)delByRealFilePath:(NSString *)realFilePath{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:realFilePath error:nil];
}

@end
