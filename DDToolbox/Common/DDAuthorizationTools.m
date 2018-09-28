//
//  DDAuthorizationTools.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/8/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDAuthorizationTools.h"

@interface DDAuthorizationTools()

@end

@implementation DDAuthorizationTools

+ (void)handlerCallback:(DDAuthorizationStatus)status completionHandler:(void (^)(DDAuthorizationStatus status))hanlder{
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
            if(hanlder){
                hanlder(DDAuthorizationNotDetermined);
            }
            break;
        case PHAuthorizationStatusRestricted:
            if(hanlder){
                hanlder(DDAuthorizationRestricted);
            }
            break;
        case PHAuthorizationStatusDenied:
            if(hanlder){
                hanlder(DDAuthorizationDenied);
            }
            break;
        case PHAuthorizationStatusAuthorized:
            if(hanlder){
                hanlder(DDAuthorizationAuthorized);
            }
            break;
        default:
            break;
    }
}

+ (void)requestAccessForMediaType:(AVMediaType)mediaType
                completionHandler:(void (^)(BOOL granted))handler
{
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:handler];
}

+ (void)checkMediaStatus:(AVMediaType)mediaType
       completionHandler:(void (^)(DDAuthorizationStatus status))hanlder
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    [self handlerCallback:(DDAuthorizationStatus)authStatus completionHandler:hanlder];
}

+ (void)requestAccessForPhoto:(void (^)(BOOL granted))handler{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(handler){
            handler(status == PHAuthorizationStatusAuthorized);
        }
    }];
}

+ (void)checkPhotoStatus:(void (^)(DDAuthorizationStatus status))hanlder{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    [self handlerCallback:(DDAuthorizationStatus)status completionHandler:hanlder];
}

+ (BOOL)checkLocationServiceEnabled{
    BOOL enabled = [CLLocationManager locationServicesEnabled];
    return enabled;
}

+ (void)checkLocationStatus:(void (^)(DDAuthorizationStatus status))hanlder{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self handlerCallback:DDAuthorizationNotDetermined completionHandler:hanlder];
            break;
        case kCLAuthorizationStatusRestricted:
            [self handlerCallback:DDAuthorizationRestricted completionHandler:hanlder];
            break;
        case kCLAuthorizationStatusDenied:
            [self handlerCallback:DDAuthorizationDenied completionHandler:hanlder];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self handlerCallback:DDAuthorizationAuthorized completionHandler:hanlder];
            break;
            
        default:
            break;
    }
}

+ (void)openAppSetting{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if(@available(iOS 10.0,*)){
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
