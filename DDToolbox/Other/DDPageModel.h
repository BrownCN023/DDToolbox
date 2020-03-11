//
//  DDPageModel.h
//  TTTDemo
//
//  Created by Brown on 2017/7/19.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

//页码分页模型
@interface DDPageModel : NSObject
@property (nonatomic,assign,readonly) uint currentPage; //当前页码，默认为0
@property (nonatomic,assign) uint pageSize;             //页大小，默认为20
@property (nonatomic,assign,readonly) BOOL isFirstPage; //是否是第一页
@property (nonatomic,assign,readonly) BOOL isNoData;    //是否是空数据状态

+ (DDPageModel *)createPageModel;
- (instancetype)initWithPage:(uint)page pageSize:(uint)pageSize;
- (void)success; //成功 - 调用后当前页码+1
- (void)failed;  //失败 - 调用后当前页码还原(当调用reset后)
- (void)noData;  //无数据 - 无数据调用后，再调success和failure方法将不起作用
- (void)reset;   //重置 - 重置后如果调用failure，可以回到重置前的值
- (void)clear;   //清除 - 清除后如果调用failure，不会回调清除前的值

@end
