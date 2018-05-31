//
//  DDSimpleViewModel.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleViewModel.h"

@implementation DDSimpleViewModel

- (id)initWithData:(id)data delegate:(id<DDSimpleViewModelDelegate>)delegate{
    if(self = [super initWithData:data]){
        _delegate = delegate;
    }
    return self;
}

@end
