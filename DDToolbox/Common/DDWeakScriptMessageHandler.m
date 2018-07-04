//
//  DDWeakScriptMessageHandler.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDWeakScriptMessageHandler.h"

@implementation DDWeakScriptMessageHandler

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
