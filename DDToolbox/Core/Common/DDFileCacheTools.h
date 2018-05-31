//
//  DDFileCacheTools.h
//  TASmartApp
//
//  Created by TongAn001 on 2018/4/16.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//文件缓存工具
@interface DDFileCacheTools : NSObject
//创建文件目录(返回错误个数)
+ (NSInteger)createCachePaths:(NSArray<NSString *> *)paths;
//获取绝对路径
+ (NSString *)getRealPathByFilePath:(NSString *)filePath;
//保存数据到目录文件，如果目录文件已存在，则删除掉旧文件，创建新的
+ (BOOL)saveData:(NSData *)data filePath:(NSString *)filePath;
//移动文件到缓存目录,oriRealFilePath原文件路径(绝对路径)，targetFilePath目标文件路径(绝对路径)
+ (BOOL)moveFileByOriRealFilePath:(NSString *)oriRealFilePath targetRealFilePath:(NSString *)targetRealFilePath;
//检查文件存在(相对路径)
+ (BOOL)checkExistsByFilePath:(NSString *)filePath;
//检查文件存在(绝对路径)
+ (BOOL)checkExistsByRealFilePath:(NSString *)filePath;
//检查文件存在(相对路径)
+ (void)checkExistsByFilePath:(NSString *)filePath completion:(void (^)(BOOL exists,BOOL isDir,NSString * filePath))completion;
//删除文件(缓存目录相对路径)
+ (BOOL)delByFilePath:(NSString *)filePath;
//删除文件(绝对路径)
+ (BOOL)delByRealFilePath:(NSString *)realFilePath;
@end
