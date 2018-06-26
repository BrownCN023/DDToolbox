//
//  DDSuperViewModel.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDSuperViewModel : NSObject

@property (nonatomic,strong) id data;

+ (id)viewModelWithData:(id)data;
- (id)initWithData:(id)data;
- (void)setupData;  //初始化数据
- (void)create;     //创建 - 用于子类实现

@end
