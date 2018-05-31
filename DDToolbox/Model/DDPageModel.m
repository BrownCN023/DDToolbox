//
//  DDPageModel.m
//  TTTDemo
//
//  Created by Brown on 2017/7/19.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import "DDPageModel.h"


@interface DDPageModel()
{
    uint _defaultPageSize;
    uint _defaultPage;
    uint _prevPage;
    BOOL _noData;
}
@end

@implementation DDPageModel

+ (DDPageModel *)createPageModel{
    return [[DDPageModel alloc] initWithPage:0 pageSize:30];
}

- (instancetype)initWithPage:(uint)page pageSize:(uint)pageSize
{
    self = [super init];
    if (self) {
        _defaultPage = page;
        _defaultPageSize = pageSize;
        [self initDataWithIsReset:NO];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultPage = 0;
        _defaultPageSize = 30;
        [self initDataWithIsReset:NO];
    }
    return self;
}

- (void)initDataWithIsReset:(BOOL)isReset
{
    _currentPage = _defaultPage;
    _pageSize = _defaultPageSize;
    _noData = NO;
    if(!isReset){
        _prevPage = _currentPage;
    }
}

- (void)success
{
    if(_noData){
        return;
    }
    _currentPage ++;
    _prevPage = _currentPage;
}

- (void)failure
{
    if(_noData){
        return;
    }
    _currentPage = _prevPage;
}

- (void)noData
{
    _noData = YES;
}

- (void)reset
{
    [self initDataWithIsReset:YES];
}

- (void)clear{
    [self initDataWithIsReset:NO];
}

- (BOOL)isFirstPage
{
    return _currentPage == _defaultPage;
}

- (BOOL)isNoData
{
    return _noData;
}

@end
