//
//  DDSuperViewModel.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDSuperViewModel : NSObject

@property (nonatomic,strong,readonly) id data;

+ (id)viewModelWithData:(id)data;
- (id)initWithData:(id)data;
- (void)setupData;
- (void)create;
- (void)updateWithData:(id)data;

@end
