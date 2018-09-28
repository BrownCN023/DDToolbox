//
//  TestWebTableViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "TestWebTableViewController.h"
#import <DDLoadingView/UIView+DDLoading.h>

@interface TestWebTableViewController ()

@end

@implementation TestWebTableViewController

- (void)dealloc{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    __weak typeof(self) weakself = self;
    self.view.onLoadingBlock = ^{
        NSURL * htmlUrl = [[NSBundle mainBundle] URLForResource:@"hello.html" withExtension:nil];
        
//        NSURL * htmlUrl = [NSURL URLWithString:@"http://inews.ifeng.com/58968759/news.shtml"];
        NSURLRequest * request = [NSURLRequest requestWithURL:htmlUrl];
        [weakself.webView loadRequest:request];
    };
    [self.view beginLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    [self.view endLoading];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.title = webView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

@end
