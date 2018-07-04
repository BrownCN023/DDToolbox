//
//  DDViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Module
    Config
    Bean
    Service(Model)
    ViewModel
    View
    Controller
 */
@interface DDViewModel : NSObject

@property (nonatomic,strong) id data;

+ (id)viewModelWithData:(id)data;
- (instancetype)initWithData:(id)data;
- (void)setupData;
- (void)create;

@end
