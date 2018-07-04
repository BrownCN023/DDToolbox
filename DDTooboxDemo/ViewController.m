//
//  ViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "ViewController.h"
#import <UIView+DDLoading.h>
#import <DDModal.h>
#import <DDSimpleMenuViewController.h>
#import <DDSimpleAlertViewController.h>
#import "DDMacro.h"
#import "TestTableAlertViewCtl.h"

#import "NSMutableArray+DDNode.h"

#import "UIView+DDDisable.h"

#import "DDLayoutButton.h"
#import "DDToolbox.h"
#import <DDCircleProgressView.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) DDCalendarManager * calendarManager;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet DDCircleProgressView *progressView;
@property (weak, nonatomic) IBOutlet DDCornerButton *dateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [DDToolboxThemeConfig sharedConfig].themeColor = DD_COLOR_Hex(0xff534d);
    __weak typeof(self) weakself = self;
    self.tableView.onLoadingBlock = ^{
        [weakself performSelector:@selector(sssto) withObject:nil afterDelay:4];
    };
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView beginLoading];
    
    DDLayoutButton * btn = [[DDLayoutButton alloc] init];
    [self.view addSubview:btn];
    
    self.calendarManager = [[DDCalendarManager alloc] initWithMinDate:[NSDate date].lastMonth maxDate:[NSDate date].nextMonth];
    DD_GCD_Global_Async(^{
        [self.calendarManager prepare];
    });
    
//    self.progressView.type = DDCircleTypeGradient;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



int flag = 0;

- (void)sssto{
    if(flag == 0){
        [self.tableView loadFailed];
    }else if(flag == 1){
        [self.tableView loadNoData];
    }else{
        [self.tableView loadError:nil];
    }
    flag ++;
}
- (IBAction)clickAlertButton:(id)sender {
    
    [DDSimpleAlertViewController showConfirm:@"操作提醒" message:@"截至2017年末，天津房地产集团有限公司及其控制的7家公司贷款余额为16.6亿元。" buttonTitle:@"是的" onOkBlock:^{
        
    }];
}
- (IBAction)clickTableButton:(id)sender {
    DDSimpleTableViewController * vctl = [[DDSimpleTableViewController alloc] init];
    vctl.items = @[
                   @{@"title":@"张三",@"value":@(1110)},
                   @{@"title":@"李四",@"value":@(1111)},
                   @{@"title":@"王五",@"value":@(1113)},
                   ];
    vctl.onClickItemBlock = ^(NSIndexPath *indexPath, id itemObj) {
        DDPLog(@"itemIndex:%@",itemObj);
    };
    vctl.fixedRowHeight = 50;
    vctl.itemTitleKeyPath = @"title";
    [vctl show:nil];
}
- (IBAction)clickActionButton:(UIButton *)sender {
    
    NSMutableArray * items = [NSMutableArray new];
    items.appendNode((flag%2==0), ^id{
        return @[@"订阅",@"不喜欢",@"举报违规"];
    });
    
    items.appendNode((flag%2==1), ^id{
        return @[@"订阅",@"收藏",@"不喜欢",@"举报违规"];
    });
    
    [DDSimpleActionViewController showAction:@"操作提醒" message:@"天津农商行与天津滨海农商行的主要股东均为天津市国资委，但两者之间并无隶属关系。" onCancelBlock:nil otherButtonItems:items onClickItemBlock:^(NSInteger itemIndex) {
        
    }];
    
    flag ++;
}

- (IBAction)clickMenuButton:(UIButton *)sender {
    CGRect originFrame = [sender.superview convertRect:sender.frame toView:DD_KeyWindow];
    
    if(flag %2 == 0){
        [DDSimpleMenuViewController showWithItems:@[@"删除",@"复制"] originFrame:originFrame showDirection:0 onClickItemBlock:^(NSInteger itemIndex) {
            
        }];
    }else{
        [DDSimpleMenuViewController showWithItems:@[@"删除",@"复制"] originFrame:originFrame showDirection:1 onClickItemBlock:^(NSInteger itemIndex) {
            
        }];
    }
    flag ++;
}
- (IBAction)clickInputButton:(id)sender {
    [DDSimpleInputViewController showAlert:@"计划" text:@"明天干嘛?" placeholder:@"明天的计划" onCancelBlock:nil onSubmitBlock:^(NSString *text) {
        
    } onValidationBlock:^BOOL(NSString *text) {
        if(DD_StringIsEmpty(text)){
            DDPLog(@"计划不能为空!");
            return NO;
        }
        return YES;
    }];
}

- (IBAction)clickSharedButton:(id)sender {
//    DDSimpleSharedViewController * vctl = [[DDSimpleSharedViewController alloc] init];
//    [vctl show:nil];
//    self.progressView.type = abs(self.progressView.type-1);
//    self.progressView.startAngle = 180.0f;
//    self.progressView.endAngle = 360.0f;
    self.progressView.strokeColor = DD_COLOR_Random();
}
- (IBAction)clickDateButton:(DDCornerButton *)sender {
    sender.cornerSize = CGSizeMake(0, 0);
    sender.corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    
    DDCalendarAlertViewController * vctl = [[DDCalendarAlertViewController alloc] initWithCalendarManager:self.calendarManager];
    vctl.onSelectedItemBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        DDPLog(@"year:%@  month:%@  day:%@",@(year),@(month),@(day));
    };
    [vctl show:nil];
}
- (IBAction)clickDisableButton:(id)sender {
    self.tableView.disable = !self.tableView.disable;
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

- (IBAction)valueChanged:(UISlider *)sender {
    self.progressView.progress = sender.value;
    
    self.dateButton.cornerSize = CGSizeMake(CGRectGetWidth(self.dateButton.bounds)/2.0*sender.value, CGRectGetHeight(self.dateButton.bounds)/2.0*sender.value);
}


@end
