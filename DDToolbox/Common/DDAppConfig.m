//
//  DDAppConfig.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import "DDAppConfig.h"

#define kConfigShowedWelcomePage @"kConfigShowedWelcomePage"
#define kConfigShowedAdvertPage @"kConfigShowedAdvertPage"

@implementation DDAppConfig

+ (DDAppConfig *)sharedConfig{
    static DDAppConfig * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DDAppConfig alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        _showedWelcomePage = [ud boolForKey:kConfigShowedWelcomePage];
        _showedAdvertPage = [ud boolForKey:kConfigShowedAdvertPage];
    }
    return self;
}

- (void)setShowedWelcomePage:(BOOL)showedWelcomePage{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:showedWelcomePage forKey:kConfigShowedWelcomePage];
    [ud synchronize];
}

- (void)setShowedAdvertPage:(BOOL)showedAdvertPage{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:showedAdvertPage forKey:kConfigShowedAdvertPage];
    [ud synchronize];
}
@end
