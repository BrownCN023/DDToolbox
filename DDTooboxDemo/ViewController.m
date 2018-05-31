//
//  ViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DDLoading.h"
#import "DDSuperModalViewController.h"
#import "DDSuperAlertViewController.h"
#import "DDSimpleAlertViewController.h"
#import "DDConfirmAlertViewController.h"
#import "DDTableAlertViewController.h"
#import "DDSimpleActionViewController.h"

#import "DDToolboxThemeConfig.h"
#import "DDMacro.h"
#import "TestTableAlertViewCtl.h"
#import "DDSimpleMenuAlertViewController.h"
#import "NSMutableArray+DDNode.h"
#import "DDSimpleInputViewController.h"
#import "DDSimpleViewModel.h"
#import "DDSimpleSharedViewController.h"

#import "DDLayoutButton.h"
#import "DDToolbox.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,strong) DDSimpleDateCalendarManager * calendarManager;

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
    [self.tableView beginLoad];
    
    DDLayoutButton * btn = [[DDLayoutButton alloc] init];
    [self.view addSubview:btn];
    
//    self.calendarManager = [[DDSimpleDateCalendarManager alloc] initWithMinYear:1970 maxYear:2030];
//    DD_GCD_Global_Async(^{
//        [self.calendarManager prepare];
//    });
    
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
        [self.tableView loadNetError];
    }
    flag ++;
}
- (IBAction)clickAlertButton:(id)sender {
    
    
    [DDConfirmAlertViewController showAlert:@"操作提醒" message:@"截至2017年末，天津房地产集团有限公司及其控制的7家公司贷款余额为16.6亿元。" onCancelBlock:nil onConfirmBlock:^{
        [TestTableAlertViewCtl showAlert:@"列表选择" items:@[
                                                         @"A",
                                                         @"B",
                                                         @"C",
                                                         @"D",
                                                         @"E",
                                                         @"F",
                                                         @"G",
                                                         ] onFixedHeightBlock:nil onCancelBlock:nil onItemBlock:^(NSInteger itemIndex, NSDictionary<NSString *,id> *item) {
                                                            DDPLog(@"itemIndex:%@",@(itemIndex));
                                                         }];
    }];
}
- (IBAction)clickTableButton:(id)sender {
    [DDTableAlertViewController showAlert:@"列表选择" items:@[
                                                     @{@"张三":@(1110)},
                                                     @{@"李四":@(1111)},
                                                     @{@"王五":@(1112)},
                                                     @{@"二娃":@(1113)},
                                                     @{@"小六":@(1114)},
                                                     @{@"王麻子":@(1114)},
                                                     @{@"狗子":@(1114)},
                                                     ] onFixedHeightBlock:nil  onCancelBlock:nil onItemBlock:^(NSInteger itemIndex, NSDictionary<NSString *,id> *item) {
                                                         DDPLog(@"itemIndex:%@",@(itemIndex));
                                                     }];
    
}
- (IBAction)clickActionButton:(UIButton *)sender {
    
    NSMutableArray * items = [NSMutableArray new];
    items.appendNode((flag%2==0), ^id{
        return @[@"订阅",@"不喜欢",@"举报违规"];
    });
    
    items.appendNode((flag%2==1), ^id{
        return @[@"订阅",@"收藏",@"不喜欢",@"举报违规"];
    });
    
    [DDSimpleActionViewController showAction:@"操作提醒" message:@"天津农商行与天津滨海农商行的主要股东均为天津市国资委，但两者之间并无隶属关系。" items:items onCancelBlock:nil onItemBlock:^(NSInteger itemIndex) {
        
    }];
    
    flag ++;
}

- (IBAction)clickMenuButton:(UIButton *)sender {
    CGRect originFrame = [sender.superview convertRect:sender.frame toView:DD_KeyWindow];
    
    if(flag %2 == 0){
        [DDSimpleMenuAlertViewController showWithItems:@[@"删除",@"复制"] originFrame:originFrame showDirection:0 onClickItemBlock:^(NSInteger itemIndex) {
            
        }];
    }else{
        [DDSimpleMenuAlertViewController showWithItems:@[@"删除",@"复制"] originFrame:originFrame showDirection:1 onClickItemBlock:^(NSInteger itemIndex) {
            
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
    DDSimpleViewModel * viewModel = [[DDSimpleViewModel alloc] init];//[DDSimpleViewModel viewModelWithData:@"Haha"];
    [viewModel create];
}

- (IBAction)clickSharedButton:(id)sender {
    DDSimpleSharedViewController * vctl = [[DDSimpleSharedViewController alloc] init];
    [vctl show:nil];
}
- (IBAction)clickDateButton:(id)sender {
//    DDSimpleDateCalendarManager * manager = [[DDSimpleDateCalendarManager alloc] init];
//    [manager prepare];
    
//    DDSimpleDateAlertViewController * vctl = [[DDSimpleDateAlertViewController alloc] initWithCalendarManager:self.calendarManager];
//    vctl.onSelectedItemBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
//        DDPLog(@"year:%@  month:%@  day:%@",@(year),@(month),@(day));
//    };
//    [vctl show:nil];
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


@end
