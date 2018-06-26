//
//  DDSimplePopTableViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimplePopTableViewController.h"

@interface DDSimplePopTableViewController ()

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * closeButton;

@end

@implementation DDSimplePopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)topHeight{
    if(DDModal_StringIsEmpty(self.alertTitle)){
        return 0.0f;
    }
    return 48.0f;
}

- (CGFloat)bottomHeight{
    return 0.0f;
}

- (CGFloat)contentHeight{
    return 380.0f;
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
    [self dismiss:^{
        if(self.onCancelBlock){
            self.onCancelBlock();
        }
    }];
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
    [self dismiss:^{
        if(self.onClickItemBlock){
            self.onClickItemBlock(indexPath, nil);
        }
    }];
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
        [v setImage:[UIImage imageNamed:@"DDModal.bundle/icon-close.png"] forState:UIControlStateNormal];
        v.tintColor = [DDModalThemeConfig sharedConfig].titleColor;
        [v addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = v;
    }
    return _closeButton;
}

@end
