//
//  DDTableWebViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/7/3.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDBaseViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "DDWeakScriptMessageHandler.h"


@interface DDWebTableViewController : DDBaseViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong,readonly) UIScrollView * scrollView;
@property (nonatomic,strong,readonly) WKWebView * webView;
@property (nonatomic,strong,readonly) UITableView * tableView;

- (WKWebViewConfiguration *)webViewConfiguration;

@end
