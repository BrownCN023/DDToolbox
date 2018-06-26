//
//  DDModalViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalViewController.h"

@interface DDModalViewController ()

@property (nonatomic,strong) UIView * modalView;

@end

@implementation DDModalViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initData];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        [self initData];
    }
    return self;
}

- (void)initData{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _setupSubviews];
    [self _setupLayout];
    
    [self setupData];
    [self setupSubviews];
    [self setupLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)_setupSubviews{
    [self.view addSubview:self.modalView];
}
- (void)_setupLayout{
    [self.modalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - Public Method
- (void)tapModalView:(UITapGestureRecognizer *)tapGes{
    [self dismiss:nil];
}

- (void)setupData{
    
}
- (void)setupSubviews{
    
}
- (void)setupLayout{
    
}
- (CGFloat)modalColorAlpha{
    return 0.3;
}
- (CGFloat)showAnimatedDuration{
    return 0.45;
}
- (CGFloat)hideAnimatedDuration{
    return 0.45;
}
- (CGFloat)springDamping{
    return 1.0;
}
- (CGFloat)springVelocity{
    return 0.1;
}
- (void)subviewShowAnimation{
    
}
- (void)subviewHideAnimation{
    
}

- (UIViewController *)topPresentedViewController{
    UIViewController * rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    return rootViewController;
}

#pragma mark - Public
- (void)show:(void (^)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController * rootViewController = self.topPresentedViewController;
        [rootViewController presentViewController:self animated:NO completion:^{
            [self viewShowAnimation:completion];
        }];
    });
}
- (void)dismiss:(void (^)(void))completion{
    [self viewHideAnimation:^{
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

- (void)viewShowAnimation:(void (^)(void))completion{
    [UIView animateWithDuration:[self showAnimatedDuration] delay:0 usingSpringWithDamping:self.springDamping initialSpringVelocity:self.springVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.modalView.alpha = 1;
        [self subviewShowAnimation];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completion){
            completion();
        }
    }];
}

- (void)viewHideAnimation:(void (^)(void))completion{
    [UIView animateWithDuration:[self showAnimatedDuration] delay:0 usingSpringWithDamping:self.springDamping initialSpringVelocity:self.springVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.modalView.alpha = 0;
        [self subviewHideAnimation];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completion){
            completion();
        }
    }];
}

#pragma mark - Setting/Getting
- (UIView *)modalView{
    if(!_modalView){
        UIView * v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.modalColorAlpha];
        v.alpha = 0.0f;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapModalView:)];
        [v addGestureRecognizer:tap];
        _modalView = v;
    }
    return _modalView;
}

@end
