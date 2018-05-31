//
//  DDResultModel.h
//  HTTPClientDemo
//
//  Created by Brown on 2017/10/26.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

//返回数据模型
@interface DDResultModel : NSObject

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,copy) NSString * msg;
@property (nonatomic,strong) id data;

+ (DDResultModel *)resultModelWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data;

- (id)initWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data;

@end
