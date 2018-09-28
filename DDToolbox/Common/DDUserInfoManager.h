//
//  DDUserInfoManager.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import <YYCache/YYCache.h>
#import "DDUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserInfoManager : NSObject

@property (nonatomic,strong,readonly) id userInfo;
@property (nonatomic,assign,readonly) BOOL hasLogin;

+ (id)sharedManager;

//userInfoClass默认为ABUserInfo.Class
- (void)registerUserInfoClass:(Class)userInfoClass;

//保存或更新用户信息到本地
- (void)saveOrUpdateUserInfo:(id)userInfo;

//清除用户信息数据
- (void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
