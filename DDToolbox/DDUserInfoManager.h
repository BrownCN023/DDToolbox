//
//  DDUserInfoManager.h
//  DDHTTPClientDemo
//
//  Created by abiaoyo on 2020/2/4.
//  Copyright © 2020 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT NSString * _Nonnull const kAppLoginNotification;
FOUNDATION_EXPORT NSString * _Nonnull const kAppLogoutNotification;

NS_ASSUME_NONNULL_BEGIN

@interface DDUserInfo : NSObject<NSCoding>
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * token;
@end


@interface DDUserInfoManager : NSObject
@property (nonatomic,strong,readonly) DDUserInfo * currentUserInfo;
@property (nonatomic,assign,readonly) BOOL hasLogin;
+ (DDUserInfoManager *)sharedManager;
- (BOOL)saveOrUpdateUserInfo:(DDUserInfo *)userInfo;
- (BOOL)clearUserInfo;
@end


@interface DDHistoryUserInfoManager : DDUserInfoManager
@property (nonatomic,strong,readonly) NSArray<DDUserInfo *> * historyArray;
+ (DDHistoryUserInfoManager *)sharedManager;
- (BOOL)clearAllHistory;
@end

NS_ASSUME_NONNULL_END
