//
//  DDUserInfo.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import "DDUserInfo.h"

@implementation DDUserInfo

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ - account:%@,token:%@,nickname:%@,avatar:%@",self.class,self.account,self.token,self.nickname,self.avatar];
}

@end
