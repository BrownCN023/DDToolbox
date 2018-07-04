//
//  DDAppVersionHelper.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/27.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDAppVersionHelper : NSObject


/**
 获取线上(appstore) app版本号

 @param appID appID
 @param chinaRegion 是否是中国区域
 @param completion 完成回调
 @return 操作队列，可用于取消操作
 */
+ (NSOperation *)getAppVersionByAppID:(NSString *)appID
                          chinaRegion:(BOOL)chinaRegion
                           completion:(void (^)(NSString * version))completion;


/**
 检查是否需要更新版本，根据当前包的版本和线上的版本作对比

 @param appID appID
 @param chinaRegion 是否是中国区域
 @param completion 完成回调
 @return 操作队列，可用于取消操作
 */
+ (NSOperation *)checkAppNeedToUpgradeByAppID:(NSString *)appID
                                  chinaRegion:(BOOL)chinaRegion
                                   completion:(void (^)(BOOL isNeed,NSString * version,NSError * error))completion;

/**
 打开app 在appStore

 @param appID appID
 @param chinaRegion 是否是中国区域
 @return 返回打开是否成功
 */
+ (BOOL)openAppInAppStoreByAppID:(NSString *)appID
                     chinaRegion:(BOOL)chinaRegion;

/**
 打开app 在appStore
 
 @param appID appID
 @param chinaRegion 是否是中国区域
 @param appName app名称
 @return 返回打开是否成功
 */
+ (BOOL)openAppInAppStoreByAppID:(NSString *)appID
                     chinaRegion:(BOOL)chinaRegion
                         appName:(NSString *)appName;

@end
