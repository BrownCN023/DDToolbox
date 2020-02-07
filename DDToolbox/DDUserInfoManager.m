//
//  DDUserInfoManager.m
//  DDHTTPClientDemo
//
//  Created by abiaoyo on 2020/2/4.
//  Copyright © 2020 abiang. All rights reserved.
//

#import "DDUserInfoManager.h"

@implementation DDUserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_account forKey:@"account"];
    [aCoder encodeObject:_token forKey:@"token"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.account = [coder decodeObjectForKey:@"account"];
        self.token = [coder decodeObjectForKey:@"token"];
    }else{
        return nil;
    }
    return self;
}
- (NSString *)description{
    return [NSString stringWithFormat:@"userinfo: .account:%@ .token:%@",self.account,self.token];
}
@end




@interface DDUserInfoManager()
@property (nonatomic,strong) DDUserInfo * currentUserInfo;
@property (nonatomic,assign) BOOL hasLogin;
@end
@implementation DDUserInfoManager
+ (NSString *)documentDirectory:(NSString *)filename{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"dduserinfo/%@",filename]];
}

+ (void)createDDUserInfoDecumentDirectory{
    NSString *path = [self documentDirectory:@""];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exists = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!exists || (exists && !isDir)){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (BOOL)saveArchiverObject:(id<NSCoding>)object key:(NSString *)key{
    NSString *path = [self documentDirectory:key];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    return success;
}

+ (id<NSCoding>)readArchiverObjectForKey:(NSString *)key{
    NSString *path = [self documentDirectory:key];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+ (BOOL)saveUserInfo:(DDUserInfo *)userInfo{
    return [self saveArchiverObject:userInfo key:@"userinfo"];
}

+ (DDUserInfo *)currentUserInfo{
    return (DDUserInfo *)[self readArchiverObjectForKey:@"userinfo"];
}

+ (DDUserInfoManager *)sharedManager{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self.class alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.class createDDUserInfoDecumentDirectory];
        self.currentUserInfo = [self.class currentUserInfo];
    }
    return self;
}
- (BOOL)hasLogin{
    return (self.currentUserInfo != nil) && self.currentUserInfo.token.length > 0;
}
- (BOOL)saveOrUpdateUserInfo:(DDUserInfo *)userInfo{
    self.currentUserInfo = userInfo;
    return [self.class saveUserInfo:userInfo];
}
- (BOOL)clearUserInfo{
    self.currentUserInfo = nil;
    return [self.class saveUserInfo:self.currentUserInfo];
}
@end




@interface DDHistoryUserInfoManager()
@property (nonatomic,strong) NSMutableArray<DDUserInfo *> * history;
@end
@implementation DDHistoryUserInfoManager
+ (BOOL)saveHistory:(NSMutableArray<DDUserInfo *> *)history{
    return [self saveArchiverObject:history key:@"history"];
}
+ (NSMutableArray<DDUserInfo *> *)currentHistory{
    return (NSMutableArray<DDUserInfo *> *)[self readArchiverObjectForKey:@"history"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        id varr = [self.class currentHistory];
        if(!varr){
            varr = [NSMutableArray new];
        }
        self.history = varr;
    }
    return self;
}

- (BOOL)saveAllHistory{
    return [self.class saveHistory:self.history];
}

- (BOOL)clearAllHistory{
    [self.history removeAllObjects];
    return [self saveAllHistory];
}

- (NSArray<DDUserInfo *> *)historyArray{
    return [_history copy];
}

- (BOOL)saveOrUpdateUserInfo:(DDUserInfo *)userInfo{
    BOOL exist = NO;
    for(NSInteger i=0;i<_history.count;i++){
        DDUserInfo * user = _history[i];
        if([user.account isEqualToString:userInfo.account]){
            exist = YES;
            [_history replaceObjectAtIndex:i withObject:userInfo];
            break;
        }
    }
    if(!exist){
        [_history addObject:userInfo];
    }
    self.currentUserInfo.token = @"";
    [self saveAllHistory];
    return [super saveOrUpdateUserInfo:userInfo];
}

- (BOOL)clearUserInfo{
    for(NSInteger i=0;i<_history.count;i++){
        DDUserInfo * user = _history[i];
        if([user.account isEqualToString:self.currentUserInfo.account]){
            user.token = @"";
            break;
        }
    }
    [self saveAllHistory];
    return [super clearUserInfo];
}

@end
