//
//  DDWeakScriptMessageHandler.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface DDWeakScriptMessageHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
