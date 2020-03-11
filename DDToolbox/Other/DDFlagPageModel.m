//
//  DDFlagPageModel.m
//  iOSAppSmartwatch
//
//  Created by brown on 2018/3/11.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDFlagPageModel.h"

@interface DDFlagPageModel(){
    uint _defaultPageSize;
    id _defaultFlag;
    id _prevFlag;
    BOOL _noData;
}
@end

@implementation DDFlagPageModel

+ (DDFlagPageModel *)createPageModel{
    return [[DDFlagPageModel alloc] initWithFlag:nil pageSize:20];
}
- (instancetype)initWithFlag:(id)flag pageSize:(uint)pageSize{
    if(self = [super init]){
        _defaultPageSize = pageSize;
        _defaultFlag = flag;
        [self initDataWithIsReset:NO];
    }
    return self;
}
- (void)initDataWithIsReset:(BOOL)isReset{
    _currentFlag = _defaultFlag;
    _pageSize = _defaultPageSize;
    _noData = NO;
    if(!isReset){
        _prevFlag = _currentFlag;
    }
}
- (void)success:(id)flag{
    if(_noData){
        return;
    }
    _currentFlag = flag;
    _prevFlag = _currentFlag;
}
- (void)failed{
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
- (BOOL)isFirstPage
{
    return _currentFlag == _defaultFlag;
}

@end
