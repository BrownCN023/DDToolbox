//
//  DDUserInfoManager.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import "DDUserInfoManager.h"

#define kDDUserInfoCache @"kDDUserInfoCache"
#define kDDUserInfo @"kDDUserInfo"

@interface DDUserInfoManager(){
    Class _userInfoClass;
}

@property (nonatomic,strong) id userInfo;

@end

@implementation DDUserInfoManager

+ (id)sharedManager{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)registerUserInfoClass:(Class)userInfoClass{
    _userInfoClass = userInfoClass;
}

- (void)saveOrUpdateUserInfo:(id)userInfo{
    _userInfo = userInfo;
    
    NSString * json = [userInfo mj_JSONString];
    YYCache * cache = [YYCache cacheWithName:kDDUserInfoCache];
    [cache setObject:json forKey:kDDUserInfo];
}

- (id)userInfo{
    if(!_userInfo){
        YYCache * cache = [YYCache cacheWithName:kDDUserInfoCache];
        id obj = [((NSString *)[cache objectForKey:kDDUserInfo]) mj_JSONObject];
        
        if(obj){
            if(!_userInfoClass){
                _userInfoClass = DDUserInfo.class;
            }
            _userInfo = [_userInfoClass mj_objectWithKeyValues:obj];
        }
    }
    return _userInfo;
}

- (void)clearUserInfo{
    YYCache * cache = [YYCache cacheWithName:kDDUserInfoCache];
    [cache removeObjectForKey:kDDUserInfo];
    self.userInfo = nil;
}

- (BOOL)hasLogin{
    return self.userInfo != nil;
}

@end
