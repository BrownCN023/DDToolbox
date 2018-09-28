//
//  DDAppConfig.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAppConfig : NSObject

+ (DDAppConfig *)sharedConfig;

@property(nonatomic,assign,readwrite) BOOL showedWelcomePage;
@property(nonatomic,assign,readwrite) BOOL showedAdvertPage;

@end

NS_ASSUME_NONNULL_END
