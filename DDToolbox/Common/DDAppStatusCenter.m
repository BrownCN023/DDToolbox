//
//  DDAppStatusCenter.m
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import "DDAppStatusCenter.h"

@interface DDAppStatusCenter()

@property (nonatomic,strong) NSHashTable * delegates;

@end

@implementation DDAppStatusCenter

+ (void)load{
    [DDAppStatusCenter sharedInstance];
}

+ (DDAppStatusCenter *)sharedInstance{
    static DDAppStatusCenter * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DDAppStatusCenter alloc] init];
    });
    return instance;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init{
    if(self = [super init]){
        [self setupData];
        [self setupNotification];
    }
    return self;
}

- (void)setupData{
    self.delegates = [NSHashTable weakObjectsHashTable];
}

- (void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name: UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name: UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name: UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name: UIApplicationWillTerminateNotification object:nil];
}

- (void)addDelegate:(id<DDAppStatusCenterDelegate>)delegate {
    @synchronized(_delegates) {
        [_delegates addObject:delegate];
    }
}

- (void)removeDelegate:(id<DDAppStatusCenterDelegate>)delegate {
    @synchronized(_delegates) {
        [_delegates removeObject:delegate];
    }
}

#pragma mark - Handle

- (void)applicationDidFinishLaunching:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationDidFinishLaunching:)]){
            [delegate applicationDidFinishLaunching:noti.object];
        }
    }
}

- (void)applicationDidBecomeActive:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationDidBecomeActive:)]){
            [delegate applicationDidBecomeActive:noti.object];
        }
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationWillEnterForeground:)]){
            [delegate applicationWillEnterForeground:noti.object];
        }
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationDidEnterBackground:)]){
            [delegate applicationDidEnterBackground:noti.object];
        }
    }
}

- (void)applicationWillResignActive:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationWillResignActive:)]){
            [delegate applicationWillResignActive:noti.object];
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)noti{
    NSArray<id<DDAppStatusCenterDelegate>> *delegates = [self.delegates allObjects];
    for(id delegate in delegates){
        if(delegate && [delegate respondsToSelector:@selector(applicationWillTerminate:)]){
            [delegate applicationWillTerminate:noti.object];
        }
    }
}


@end
