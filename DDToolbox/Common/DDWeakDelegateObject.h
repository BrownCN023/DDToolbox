//
//  DDWeakDelegateObject.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/21.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDWeakDelegateObject : NSObject

@property (nonatomic,strong,readonly) NSArray * allDelegates;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end
