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

@property (nonatomic,strong,readonly) id currentFlag;   //当前页标记
@property (nonatomic,assign) uint pageSize;             //页大小，默认为20
@property (nonatomic,assign,readonly) BOOL isFirstPage; //是否是第一页
@property (nonatomic,assign,readonly) BOOL isNoData;    //是否是空数据状态

+ (DDFlagPageModel *)createPageModel;
- (instancetype)initWithFlag:(id)flag pageSize:(uint)pageSize;
- (void)success:(id)flag;  //成功 - 调用设置当前标记flag
- (void)failed;            //失败 - 调用后当前页码还原(当调用reset后)
- (void)noData;            //无数据 - 无数据调用后，再调success:和failed方法将不起作用
- (void)reset;             //重置 - 重置后如果调用failed，可以回到重置前的值
- (void)clear;             //清除 - 清除后如果调用failed，不会回调清除前的值

@end
