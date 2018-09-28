//
//  DDBaseViewController.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDMacro.h"

@interface DDBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DDBaseViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DDPLog(@"--- dealloc %@ ---",self.class);
}

- (id)init{
    if(self = [super init]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupNoti];
    [self setupNavigation];
    [self setupSubviews];
    [self setupLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

#pragma mark - Setup
- (void)setupData{
    
}

- (void)setupNoti{
    
}

- (void)setupNavigation{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(0, 0, 50, 44);
    [leftButton setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-left.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickNavLeftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    _navLeftButton = leftButton;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 50, 44);
    [rightButton addTarget:self action:@selector(clickNavRightButton) forControlEvents:UIControlEventTouchUpInside];
    rightButton.hidden = YES;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _navRightButton = rightButton;
}

- (void)setupSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLayout{
    
}

- (void)clickNavLeftButton{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)clickNavRightButton{
    
}


@end
