//
//  DDFlagPageModel.h
//  iOSAppSmartwatch
//
//  Created by brown on 2018/3/11.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//标记分页模型
@interface DDFlagPageModel : NSObject

@property (nonatomic,strong,readonly) id currentFlag;  //当前页标记
@property (nonatomic,assign) uint offset;           //当前页偏移(基于currentFlag的偏移)
@property (nonatomic,assign,readonly,getter=isNoData) BOOL noData;

+ (DDFlagPageModel *)createFlagPageModel;
- (instancetype)initWithFlag:(id)flag offset:(uint)offset;
- (void)signFlag:(id)flag;
- (void)error;
- (void)reset;
- (void)noData;
- (void)clear;

@end
