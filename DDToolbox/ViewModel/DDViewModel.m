//
//  DDViewModel.m
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"

@implementation DDViewModel

+ (id)viewModelWithData:(id)data{
    id model = [[[self class] alloc] initWithData:data];
    return model;
}
- (instancetype)initWithData:(id)data{
    if(self = [super init]){
        _data = data;
        [self setupData];
    }
    return self;
}
- (void)setupData{
    
}
- (void)create{
    
}

@end
