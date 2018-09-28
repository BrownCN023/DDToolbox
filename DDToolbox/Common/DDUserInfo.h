//
//  DDUserInfo.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUserInfo : NSObject

@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * token;
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * avatar;

@end

NS_ASSUME_NONNULL_END
