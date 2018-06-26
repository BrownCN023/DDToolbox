//
//  DDSuperViewModel.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperViewModel.h"

@interface DDSuperViewModel()

@end

@implementation DDSuperViewModel

+ (id)viewModelWithData:(id)data{
    id model = [[[self class] alloc] initWithData:data];
    return model;
}

- (id)init{
    if(self = [super init]){
        [self setupData];
    }
    return self;
}

- (id)initWithData:(id)data{
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
