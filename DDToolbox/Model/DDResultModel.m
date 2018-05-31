//
//  DDResultModel.m
//  HTTPClientDemo
//
//  Created by Brown on 2017/10/26.
//  Copyright © 2017年 Brown. All rights reserved.
//

#import "DDResultModel.h"

@implementation DDResultModel

+ (DDResultModel *)resultModelWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data{
    DDResultModel * resultModel = [[DDResultModel alloc] initWithCode:code msg:msg data:data];
    return resultModel;
}

- (id)initWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data{
    if(self = [super init]){
        self.code = code;
        self.msg = msg;
        self.data = data;
    }
    return self;
}

@end
