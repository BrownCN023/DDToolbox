//
//  ViewController3.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "ViewController3.h"
#import "DDAppVersionHelper.h"

@interface PersonModel : NSObject

@end

@implementation PersonModel

+ (BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"++++++++++++++++  resolveClassMethod  ++++++++++++++");
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"++++++++++++++++  resolveInstanceMethod  ++++++++++++++");
    return NO;
}

@end


@interface ViewController3 ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)clickChangeButton:(id)sender {
//    PersonModel * person = [PersonModel new];
//    [person performSelector:@selector(test)];
    [DDAppVersionHelper getAppVersionByAppID:@"1390178593" chinaRegion:YES completion:^(NSString *version) {
        NSLog(@"version:%@",version);
    }];
    
    [DDAppVersionHelper checkAppNeedToUpgradeByAppID:@"1390178593" chinaRegion:YES completion:^(BOOL isNeed, NSString * version, NSError *error) {
        NSLog(@"isNeed:%@  version:%@  error:%@",@(isNeed),version,error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickbackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
