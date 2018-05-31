//
//  DDTableAlertViewController.m
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTableAlertViewController.h"
#import <Masonry/Masonry.h>
#import "DDMacro.h"

#define DDTableAlertItemHeight 50.0f

@interface DDTableAlertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * closeButton;
@property (nonatomic,strong) NSArray * items;

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^itemBlock)(NSInteger itemIndex, id item);
@property (nonatomic,copy) CGFloat (^fixedHeightBlock)(void);
@end

@implementation DDTableAlertViewController

+ (DDTableAlertViewController *)showAlert:(NSString *)title
                                    items:(NSArray *)items
                       onFixedHeightBlock:(CGFloat (^)(void))fixedHeightBlock
                            onCancelBlock:(void (^)(void))cancelBlock
                              onItemBlock:(void (^)(NSInteger itemIndex, id item))itemBlock{
    DDTableAlertViewController * vctl = [[[self class] alloc] init];
    vctl.alertTitle = title;
    vctl.items = items;
    vctl.fixedHeightBlock = fixedHeightBlock;
    vctl.cancelBlock = cancelBlock;
    vctl.itemBlock = itemBlock;
    [vctl show:nil];
    return vctl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)topHeight{
    if(DD_StringIsEmpty(self.alertTitle)){
        return 0.0f;
    }
    return 48.0f;
}

- (CGFloat)contentHeight{
    if(self.fixedHeightBlock){
        return self.fixedHeightBlock();
    }
    if(DD_ArrayIsEmpty(self.items)){
        if(self.topHeight == 0.0f){
            return 50.0f;
        }
        return 0.0f;
    }
    
    CGFloat maxHeight = DD_ScreenHeight-180-self.topHeight;
    CGFloat targetHeight = self.items.count*[self cellRowHeight];
    if(targetHeight > maxHeight){
        return maxHeight;
    }
    return targetHeight;
}
- (CGFloat)bottomHeight{
    return 0.0f;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.closeButton];
    
    [self.contentView addSubview:self.tableView];
}
- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.right.equalTo(self.topView).offset(-15);
        make.top.equalTo(self.topView).offset(0);
        make.bottom.equalTo(self.topView).offset(0);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.topView);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView);
    }];
}


- (void)clickCloseButton:(UIButton *)sender{
    [self dismiss:nil];
}

- (CGFloat)cellRowHeight{
    return DDTableAlertItemHeight;
}

- (UITableViewCell *)tableAlertController:(DDTableAlertViewController *)controller tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary * item = self.items[indexPath.row];
    cell.textLabel.text = item.allKeys.firstObject;
    return cell;
}

- (void)tableAlertController:(DDTableAlertViewController *)controller tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * item = self.items[indexPath.row];
    [self dismiss:^{
        if(self.itemBlock){
            self.itemBlock(indexPath.row,item);
        }
    }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellRowHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableAlertController:self tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableAlertController:self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Setter/Getter
- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        v.delegate = self;
        v.dataSource = self;
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
        _tableView = v;
    }
    return _tableView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        //        v.backgroundColor = DD_COLOR_Random();
        v.text = self.alertTitle;
        v.textColor = [UIColor whiteColor];
        //        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/icon-close.png"] forState:UIControlStateNormal];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].titleColor;
        [v addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = v;
    }
    return _closeButton;
}

@end
