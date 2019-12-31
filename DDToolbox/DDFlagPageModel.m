//
//  DDFlagPageModel.m
//  iOSAppSmartwatch
//
//  Created by brown on 2018/3/11.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDFlagPageModel.h"

@interface DDFlagPageModel(){
    uint _defaultOffset;
    id _defaultFlag;
    id _prevFlag;
    BOOL _noData;
}
@end

@implementation DDFlagPageModel

+ (DDFlagPageModel *)createFlagPageModel{
    return [[DDFlagPageModel alloc] initWithFlag:nil offset:30];
}
- (instancetype)initWithFlag:(id)flag offset:(uint)offset{
    if(self = [super init]){
        _defaultOffset = offset;
        _defaultFlag = flag;
        [self initDataWithIsReset:NO];
    }
    return self;
}
- (void)initDataWithIsReset:(BOOL)isReset{
    _currentFlag = _defaultFlag;
    _offset = _defaultOffset;
    _noData = NO;
    if(!isReset){
        _prevFlag = _currentFlag;
    }
}
- (void)signFlag:(id)flag{
    if(_noData){
        return;
    }
    _currentFlag = flag;
    _prevFlag = _currentFlag;
}
- (void)error{
    if(_noData){
        return;
    }
    _currentFlag = _prevFlag;
}
- (void)reset{
    [self initDataWithIsReset:YES];
}
- (void)noData{
    _noData = YES;
}
- (void)clear{
    [self initDataWithIsReset:NO];
}
- (BOOL)isNoData{
    return _noData;
}

@end
