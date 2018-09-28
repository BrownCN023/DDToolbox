//
//  DDAuthorizationTools.h
//  TASmartApp
//
//  Created by TongAn001 on 2018/8/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger,DDAuthorizationStatus) {
    DDAuthorizationNotDetermined = 0,//没有询问是否开启麦克风
    DDAuthorizationRestricted,//未授权，家长限制
    DDAuthorizationDenied,//玩家未授权
    DDAuthorizationAuthorized //玩家授权
};


@interface DDAuthorizationTools : NSObject

+ (void)requestAccessForMediaType:(AVMediaType)mediaType
                completionHandler:(void (^)(BOOL granted))handler;
+ (void)checkMediaStatus:(AVMediaType)mediaType
       completionHandler:(void (^)(DDAuthorizationStatus status))hanlder;

+ (void)requestAccessForPhoto:(void (^)(BOOL granted))handler;
+ (void)checkPhotoStatus:(void (^)(DDAuthorizationStatus status))hanlder;

+ (BOOL)checkLocationServiceEnabled;
+ (void)checkLocationStatus:(void (^)(DDAuthorizationStatus status))hanlder;


+ (void)openAppSetting;

@end
