//
//  DDSimpleAlertViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/27.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"

#define DDSimpleAlertRowHeight 52.0f

@interface DDSimpleAlertItemCell : UITableViewCell

@property (nonatomic,strong) UILabel * itemLabel;
@property (nonatomic,strong) UIView * topLineView;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,copy) void (^onClickItemButtonBlock)(NSIndexPath * indexPath);

- (void)configWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@implementation DDSimpleAlertItemCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupData{
    
}

- (void)setupSubviews{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
    
    [self.contentView addSubview:self.itemLabel];
    [self.contentView addSubview:self.topLineView];
}

- (void)setupLayout{
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)configWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.itemLabel.text = title;
    if(indexPath.section == 0 && indexPath.row == 0){
        self.topLineView.hidden = YES;
    }else{
        self.topLineView.hidden = NO;
    }
}

- (void)clickItemButton:(UIButton *)sender{
    if(self.onClickItemButtonBlock){
        self.onClickItemButtonBlock(self.indexPath);
    }
}

- (UILabel *)itemLabel{
    if(!_itemLabel){
        UILabel * v = [[UILabel alloc] init];
        v.font = [UIFont boldSystemFontOfSize:18];
        v.textAlignment = NSTextAlignmentCenter;
        v.textColor = [DDModalThemeConfig sharedConfig].tintColor;
        _itemLabel = v;
    }
    return _itemLabel;
}

- (UIView *)topLineView{
    if(!_topLineView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
        _topLineView = v;
    }
    return _topLineView;
}

@end


@interface DDSimpleAlertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) NSAttributedString * alertTitleAttr;
@property (nonatomic,copy) NSString * alertMessage;
@property (nonatomic,copy) NSAttributedString * alertMessageAttr;

@property (nonatomic,assign) CGFloat alertTitleHeight;
@property (nonatomic,assign) CGFloat alertMessageHeight;


@property (nonatomic,copy) NSString * itemKeyPath;
@property (nonatomic,strong) NSArray * items;

@property (nonatomic,assign) BOOL isConfirm;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,copy) NSString * cancelTitle;
@property (nonatomic,copy) NSString * okTitle;
@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * okButton;

@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^clickItemBlock)(NSInteger itemIndex);

@end

@implementation DDSimpleAlertViewController

+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                                 buttonTitle:(NSString *)buttonTitle
                                   onOkBlock:(void (^)(void))okBlock{
    return [self showAlert:title message:message cancelButtonTitle:buttonTitle onCancelBlock:okBlock otherButtonItems:nil itemKeyPath:nil onClickItemBlock:nil];
}

+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                               onCancelBlock:(void (^)(void))cancelBlock
                                   onOkBlock:(void (^)(NSInteger itemIndex))okBlock
{
    return [self showAlert:title message:message cancelButtonTitle:@"取消" onCancelBlock:cancelBlock otherButtonItems:@[@"确定"] itemKeyPath:nil onClickItemBlock:okBlock];
}


+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelButtonTitle
                               onCancelBlock:(void (^)(void))cancelBlock
                               okButtonTitle:(NSString *)okButtonTitle
                                   onOkBlock:(void (^)(NSInteger itemIndex))okBlock
{
    return [self showAlert:title message:message cancelButtonTitle:cancelButtonTitle onCancelBlock:cancelBlock otherButtonItems:@[okButtonTitle] itemKeyPath:nil onClickItemBlock:okBlock];
}


+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSString *> *)otherButtonItems
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock
{
    return [self showAlert:title message:message cancelButtonTitle:@"取消" onCancelBlock:cancelBlock otherButtonItems:otherButtonItems itemKeyPath:nil onClickItemBlock:clickItemBlock];
}

+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSString *> *)otherButtonItems
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock
{
    return [self showAlert:title message:message cancelButtonTitle:cancelButtonTitle onCancelBlock:cancelBlock otherButtonItems:otherButtonItems itemKeyPath:nil onClickItemBlock:clickItemBlock];
}

+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSObject *> *)otherButtonItems
                               itemKeyPath:(NSString *)itemKeyPath
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;
{
    DDSimpleAlertViewController * vctl = [[DDSimpleAlertViewController alloc] init];
    if(!title){
        title = message;
        message = nil;
    }
    vctl.alertTitle = title;
    vctl.alertMessage = message;
    vctl.itemKeyPath = itemKeyPath;
    vctl.items = otherButtonItems;
    vctl.cancelTitle = cancelButtonTitle;
    vctl.cancelBlock = cancelBlock;
    vctl.clickItemBlock = clickItemBlock;
    
    if(otherButtonItems.count == 1){
        vctl.isConfirm = YES;
        if(itemKeyPath){
            vctl.okTitle = [[otherButtonItems firstObject] valueForKeyPath:itemKeyPath];
        }else{
            vctl.okTitle = (NSString *)[otherButtonItems firstObject];
        }
    }
    
    CGFloat targetMaxWidth = (DDModal_ScreenWidth-vctl.popMarginLeft-vctl.popMarginRight-30);
    
    if(!DDModal_StringIsEmpty(title)){
        vctl.alertTitleAttr = [title modalSimpleAttributedString:[UIFont boldSystemFontOfSize:17]
                                                               color:[UIColor whiteColor]
                                                         lineSpacing:0.5
                                                           alignment:NSTextAlignmentCenter];
        CGFloat alertTitleHeight = [vctl.alertTitleAttr
                                      boundingRectWithSize:CGSizeMake(targetMaxWidth, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      context:nil].size.height+0.5;
        vctl.alertTitleHeight = alertTitleHeight;
    }
    
    if(!DDModal_StringIsEmpty(message)){
        vctl.alertMessageAttr = [message modalSimpleAttributedString:[UIFont systemFontOfSize:13]
                                                               color:[UIColor whiteColor]
                                                         lineSpacing:0.5
                                                           alignment:NSTextAlignmentCenter];
        CGFloat alertMessageHeight = [vctl.alertMessageAttr
                                      boundingRectWithSize:CGSizeMake(targetMaxWidth, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      context:nil].size.height+0.5;
        vctl.alertMessageHeight = alertMessageHeight;
    }
    
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
    CGFloat targetTopHeight = self.titleMarginTop + self.alertTitleHeight + self.titleMarginBottom + self.messageMarginTop + self.alertMessageHeight + self.messageMarginBottom;
    return targetTopHeight;
}

- (CGFloat)titleMarginTop{
    if(self.alertTitleHeight > 0){
        return 18.0f;
    }
    return 0.0f;
}

- (CGFloat)titleMarginBottom{
    if(self.alertTitleHeight > 0 && self.alertMessageHeight <= 0){
        return 18.0;
    }
    return 0.0f;
}

- (CGFloat)messageMarginTop{
    if(self.alertMessageHeight <= 0){
        return 0.0;
    }
    if(self.alertTitleHeight > 0){
        return 3.0f;
    }
    return 22.0f;
}
- (CGFloat)messageMarginBottom{
    if(self.alertMessageHeight <= 0){
        return 0.0;
    }
    return 22.0f;
}

- (CGFloat)contentHeight{
    if(_isConfirm){
        return 0.0f;
    }
    CGFloat maxHeight = DDModal_ScreenHeight-DDSimpleAlertRowHeight;
    CGFloat targetMaxHeight = maxHeight - self.topHeight - self.bottomHeight;
    
    CGFloat itemHeight = (self.items.count+1)*DDSimpleAlertRowHeight;
    if(itemHeight > targetMaxHeight){
        self.tableView.scrollEnabled = YES;
        itemHeight = targetMaxHeight;
    }
    return itemHeight;
}

- (CGFloat)bottomHeight{
    if(_isConfirm){
        return 48;
    }
    return 0.0f;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.messageLabel];
    [self.contentView addSubview:self.tableView];
    
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addSubview:self.okButton];
     
    [self.tableView registerClass:[DDSimpleAlertItemCell class] forCellReuseIdentifier:@"DDSimpleAlertItemCell"];
    
    UIView * hLineView = [[UIView alloc] init];
    hLineView.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
    [self.bottomView addSubview:hLineView];
    
    UIView * vLineView = [[UIView alloc] init];
    vLineView.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
    [self.bottomView addSubview:vLineView];
    
    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(self.bottomView);
    }];
}
- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self.alertTitleHeight);
        make.top.mas_equalTo(self.titleMarginTop);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self.alertMessageHeight);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(self.messageMarginTop);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.equalTo(self.okButton);
        make.right.equalTo(self.okButton.mas_left);
    }];
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.equalTo(self.cancelButton);
    }];
}


- (void)clickCancelButton:(UIButton *)sender{
    [self dismiss:^{
        if(self.cancelBlock){
            self.cancelBlock();
        }
    }];
}

- (void)clickOkButton:(UIButton *)sender{
    [self handleClickItemByItemIndex:0];
}

- (void)handleClickItemByItemIndex:(NSInteger)itemIndex{
    [self dismiss:^{
        if(self.clickItemBlock){
            self.clickItemBlock(itemIndex);
        }
    }];
}

- (void)tapModalView:(UITapGestureRecognizer *)tapGes{
    
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_isConfirm){
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isConfirm){
        return 0;
    }
    if(section == 0){
        return self.items.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DDSimpleAlertRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * title = nil;
    if(indexPath.section == 1){
        title = self.cancelTitle;
    }else{
        if(self.itemKeyPath){
            id item = self.items[indexPath.row];
            title = [item valueForKeyPath:self.itemKeyPath];
        }else{
            title = self.items[indexPath.row];
        }
    }
    
    DDSimpleAlertItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DDSimpleAlertItemCell" forIndexPath:indexPath];
    [cell configWithTitle:title indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        [self handleClickItemByItemIndex:indexPath.row];
    }else{
        [self clickCancelButton:nil];
    }
}

#pragma mark - Setter/Getter
- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.numberOfLines = 0;
        v.attributedText = self.alertTitleAttr;
        //v.backgroundColor = DDModal_COLOR_Hex(0xa2e923);
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] init];
        v.numberOfLines = 0;
        v.attributedText = self.alertMessageAttr;
        //v.backgroundColor = DDModal_COLOR_Hex(0xaa3e3e);
        _messageLabel = v;
    }
    return _messageLabel;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:self.cancelTitle forState:UIControlStateNormal];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDModalThemeConfig sharedConfig].tintColor;
        [v setTitleColor:[DDModalThemeConfig sharedConfig].tintColor forState:UIControlStateNormal];
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        v.hidden = !_isConfirm;
        v.highlightColor = DDModal_COLOR_Hex(0xE6E6E6);
        _cancelButton = v;
    }
    return _cancelButton;
}

- (UIButton *)okButton{
    if(!_okButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:self.okTitle forState:UIControlStateNormal];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDModalThemeConfig sharedConfig].tintColor;
        [v setTitleColor:[DDModalThemeConfig sharedConfig].tintColor forState:UIControlStateNormal];
        [v addTarget:self action:@selector(clickOkButton:) forControlEvents:UIControlEventTouchUpInside];
        v.hidden = !_isConfirm;
        v.highlightColor = DDModal_COLOR_Hex(0xE6E6E6);
        _okButton = v;
    }
    return _okButton;
}

- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        v.delegate = self;
        v.dataSource = self;
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
        v.separatorStyle = UITableViewCellSeparatorStyleNone;
        v.scrollEnabled = NO;
        _tableView = v;
    }
    return _tableView;
}

@end
