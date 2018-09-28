//
//  DDTableWebViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/7/3.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDWebTableViewController.h"

@interface DDWebTableViewController (){
    CGFloat _scrollViewContentHeight;
    CGFloat _webViewContentHeight;
    CGFloat _tableViewContentHeight;
}
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation DDWebTableViewController

- (void)dealloc{
    [self.webView stopLoading];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSValue * value = change[NSKeyValueChangeNewKey];
    CGSize newContentSize = [value CGSizeValue];
    
    if([keyPath isEqualToString:@"contentSize"]){
        if(newContentSize.height != _tableViewContentHeight){
            _tableViewContentHeight = newContentSize.height;
            self.tableView.frame = CGRectMake(0, _webViewContentHeight, CGRectGetWidth(self.view.bounds), _tableViewContentHeight);
        }
    }else{
        if(newContentSize.height != _webViewContentHeight){
            _webViewContentHeight = newContentSize.height;
            self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), _webViewContentHeight);
            self.tableView.frame = CGRectMake(0, _webViewContentHeight, CGRectGetWidth(self.view.bounds), _tableViewContentHeight);
        }
    }
    CGFloat scrollViewContentHeight = _webViewContentHeight+_tableViewContentHeight;
    if(scrollViewContentHeight != _scrollViewContentHeight){
        _scrollViewContentHeight = scrollViewContentHeight;
        
        CGSize scrollContentSize = self.scrollView.contentSize;
        scrollContentSize.height = _scrollViewContentHeight;
        self.scrollView.contentSize = scrollContentSize;
    }
    
}

- (WKWebViewConfiguration *)webViewConfiguration{
    // 创建配置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 创建UserContentController（提供JavaScript向webView发送消息的方法）
    WKUserContentController* userContent = [[WKUserContentController alloc] init];
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [userContent addScriptMessageHandler:[[DDWeakScriptMessageHandler alloc] initWithDelegate:self] name:@"appVersion"];
    // 将UserConttentController设置到配置文件
    config.userContentController = userContent;
    return config;
}

#pragma mark - Setup
- (void)setupNoti{
    [super setupNoti];
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupNavigation{
    [super setupNavigation];
    self.navRightButton.hidden = NO;
    [self.navRightButton setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-shared.png"] forState:UIControlStateNormal];
}

- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.webView];
    [self.scrollView addSubview:self.tableView];
}

- (void)setupLayout{
    [super setupLayout];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"Text";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter/Getter
- (UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView * v = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        v.backgroundColor = [UIColor whiteColor];
        _scrollView = v;
    }
    return _scrollView;
}

- (WKWebView *)webView{
    if(!_webView){
        WKWebView * v = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[self webViewConfiguration]];
        v.navigationDelegate = self;
        v.UIDelegate = self;
        v.scrollView.scrollEnabled = NO;
        _webView = v;
    }
    return _webView;
}

- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        v.delegate = self;
        v.dataSource = self;
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
        v.scrollEnabled = NO;
        _tableView = v;
    }
    return _tableView;
}

@end
