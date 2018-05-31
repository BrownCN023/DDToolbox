//
//  DDWeakDelegate.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/3/28.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDWeakDelegate : NSObject

@property (nonatomic,weak,readonly) id delegate;

- (instancetype)initWithDelegate:(id)delegate;

@end
