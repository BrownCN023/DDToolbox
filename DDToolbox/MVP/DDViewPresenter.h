//
//  DDViewPresenter.h
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
    Interface(Protocol)
    Service(Model)
    Presenter
    View
    Controller
 */
@interface DDViewPresenter : NSObject

@property (nonatomic,weak) UIView * view;

- (instancetype)initWithView:(UIView *)view;

@end
