//
//  DDAppVersionHelper.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/27.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDAppVersionHelper.h"

@implementation DDAppVersionHelper

+ (NSOperationQueue *)sharedQueue{
    static NSOperationQueue * queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

+ (NSOperation *)getAppVersionByAppID:(NSString *)appID
                          chinaRegion:(BOOL)chinaRegion
                           completion:(void (^)(NSString * version))completion
{
    NSString * appURL = nil;
    
    if(chinaRegion){
        appURL = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appID];
    }else{
        appURL = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appID];
    }
    
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSData * jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:appURL]];
        NSError * error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&error];
        NSArray * appInfos = dic[@"results"];
        NSDictionary * appInfo = [appInfos firstObject];
        NSString * version = appInfo[@"version"];
        
        if(completion){
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(version);
            });
        }
    }];
    [[self sharedQueue] addOperation:operation];
    return operation;
}

+ (NSOperation *)checkAppNeedToUpgradeByAppID:(NSString *)appID
                                  chinaRegion:(BOOL)chinaRegion
                                   completion:(void (^)(BOOL isNeed,NSString * version,NSError * error))completion
{
    
    return [self getAppVersionByAppID:appID chinaRegion:chinaRegion completion:^(NSString *version) {
        
        if(!version){
            if(completion){
                NSError * error = [NSError errorWithDomain:NSLocalizedDescriptionKey
                                                      code:0
                                                  userInfo:[NSDictionary dictionaryWithObject:@"appstore version is nil" forKey:NSLocalizedDescriptionKey]];
                completion(NO,nil,error);
            }
            return;
        }
        
        NSString * currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSComparisonResult result = [currentAppVersion compare:version];
        BOOL isNeed = (result == NSOrderedAscending);
        
        if(completion){
            completion(isNeed,version,nil);
        }
    }];
}

+ (BOOL)openAppInAppStoreByAppID:(NSString *)appID
                     chinaRegion:(BOOL)chinaRegion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    return [self openAppInAppStoreByAppID:appID chinaRegion:chinaRegion appName:app_Name];
}

+ (BOOL)openAppInAppStoreByAppID:(NSString *)appID
                     chinaRegion:(BOOL)chinaRegion
                         appName:(NSString *)appName
{
    NSString * appURL = [NSString stringWithFormat:@"https://itunes.apple.com%@/app/%@/id%@?mt=8",chinaRegion?@"/cn":@"",appName,appID];
    appURL = [appURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
}


@end
