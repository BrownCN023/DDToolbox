//
//  DDSimpleActionViewController.m
//  DDTooboxDemo
//
//  Created by brown on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleActionViewController.h"
#import "NSString+DDModal.h"

#define DDSimpleActionItemHeight 52.0f

#define DDSimpleActionMarginLeftRight 20.0f
#define DDSimpleActionMarginTopBottom 15.0f


@interface DDSimpleActionItemCell : UITableViewCell

@property (nonatomic,strong) UIButton * itemButton;
@property (nonatomic,strong) UIView * topLineView;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,copy) void (^onClickItemButtonBlock)(NSIndexPath * indexPath);

- (void)configWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@implementation DDSimpleActionItemCell

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
    [self.contentView addSubview:self.itemButton];
    [self.contentView addSubview:self.topLineView];
}

- (void)setupLayout{
    [self.itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.itemButton setTitle:title forState:UIControlStateNormal];
}

- (void)clickItemButton:(UIButton *)sender{
    if(self.onClickItemButtonBlock){
        self.onClickItemButtonBlock(self.indexPath);
    }
}

- (UIButton *)itemButton{
    if(!_itemButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.backgroundColor = [UIColor whiteColor];
        v.tintColor = [DDModalThemeConfig sharedConfig].tintColor;
        [v addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        _itemButton = v;
    }
    return _itemButton;
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




@interface DDSimpleActionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * cancelButton;


@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) NSAttributedString * alertMessageAttr;
@property (nonatomic,assign) CGFloat alertMessageHeight;

@property (nonatomic,copy) NSString * cancelTitle;
@property (nonatomic,copy) NSArray * items;
@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^itemBlock)(NSInteger itemIndex);

@end

@implementation DDSimpleActionViewController

+ (id)showAction:(NSString *)title
         message:(NSString *)message
           items:(NSArray<NSString *> *)items
   onCancelBlock:(void (^)(void))cancelBlock
     onItemBlock:(void (^)(NSInteger itemIndex))itemBlock{
    return [self showAction:title
                    message:message
                     cancel:nil
                      items:items
              onCancelBlock:cancelBlock
                onItemBlock:itemBlock];
}

+ (id)showAction:(NSString *)title
         message:(NSString *)message
          cancel:(NSString *)cancel
           items:(NSArray<NSString *> *)items
   onCancelBlock:(void (^)(void))cancelBlock
     onItemBlock:(void (^)(NSInteger itemIndex))itemBlock{
    DDSimpleActionViewController * vctl = [[[self class] alloc] init];
    vctl.alertTitle = title;
    
    if(!DDModal_StringIsEmpty(message)){
        vctl.alertMessageAttr = [message modalSimpleAttributedString:[UIFont boldSystemFontOfSize:18]
                    color:[DDModalThemeConfig sharedConfig].messageColor
                    lineSpacing:0.5
                    alignment:NSTextAlignmentCenter];
        
        CGFloat alertMessageHeight = [vctl.alertMessageAttr
                                      boundingRectWithSize:CGSizeMake((DDModal_ScreenWidth-vctl.popMarginLeft-vctl.popMarginRight-DDSimpleActionMarginLeftRight*2), CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      context:nil].size.height+0.1;
        vctl.alertMessageHeight = alertMessageHeight<40.0f?40.0f:alertMessageHeight;
    }
    vctl.cancelTitle = cancel;
    vctl.items = items;
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

- (DDModalPopAnimation)showPopAnimation{
    return DDModalPopAnimationBottom;
}
- (DDModalPopAnimation)hidePopAnimation{
    return DDModalPopAnimationBottom;
}

- (CGFloat)popMarginLeft{
    return 10.0f;
}
- (CGFloat)popMarginRight{
    return 10.0f;
}
- (CGFloat)popMarginBottom{
    return 0.0f;
}
- (CGFloat)bottomHeight{
    return DDSimpleActionItemHeight+20;
}
- (CGFloat)topHeight{
    return DDModal_StringIsEmpty(self.alertTitle)?0.0f:48.0f;
}

- (CGFloat)contentHeight{
    CGFloat totalContentHeight = self.items.count*DDSimpleActionItemHeight+self.targetAlertMessageHeight;
    CGFloat maxHeight = DDModal_ScreenHeight-64;
    BOOL scrollEnabled = NO;
    if(totalContentHeight+self.topHeight+self.bottomHeight > maxHeight){
        totalContentHeight = maxHeight-(self.topHeight+self.bottomHeight);
        scrollEnabled = YES;
    }
    self.tableView.scrollEnabled = scrollEnabled;
    return totalContentHeight;
}

- (CGFloat)targetAlertMessageHeight{
    if(self.alertMessageHeight == 0.0f){
        return 0.0f;
    }
    return self.alertMessageHeight+DDSimpleActionMarginTopBottom*2;
}

- (CGFloat)messageMarginTop{
    if(self.alertMessageHeight == 0.0f){
        return 0.0f;
    }
    return DDSimpleActionMarginTopBottom;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}

- (void)setupSubviews{
    [super setupSubviews];
    
    self.popView.backgroundColor = [UIColor clearColor];
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    [self.topView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.tableView];
    [self.bottomView addSubview:self.cancelButton];
    
    [self.tableView registerClass:[DDSimpleActionItemCell class] forCellReuseIdentifier:@"DDSimpleActionItemCell"];
    [self.contentView modalLayerCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.popMarginLeft-self.popMarginRight, self.contentHeight) cornerSize:self.cornerSize];
    [self.cancelButton modalLayerCorners:(UIRectCornerAllCorners) cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.popMarginLeft-self.popMarginRight, self.bottomHeight-20) cornerSize:self.cornerSize];
}

- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.right.equalTo(self.topView).offset(-15);
        make.top.equalTo(self.topView).offset(0);
        make.bottom.equalTo(self.topView).offset(0);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(DDSimpleActionMarginTopBottom);
        make.right.equalTo(self.contentView).offset(-DDSimpleActionMarginTopBottom);
        make.top.equalTo(self.contentView).offset(self.messageMarginTop);
        make.height.mas_equalTo(self.alertMessageHeight);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        make.left.equalTo(self.bottomView).offset(0);
        make.right.equalTo(self.bottomView).offset(0);
        make.bottom.equalTo(self.bottomView).offset(-10);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(self.targetAlertMessageHeight);
    }];
}

- (void)clickCancelButton:(id)sender{
    [self dismiss:nil];
}

#pragma mark - UITableViewDelegate/UITableVeiwDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DDSimpleActionItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DDSimpleActionItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DDSimpleActionItemCell" forIndexPath:indexPath];
    if(!cell.onClickItemButtonBlock){
        __weak typeof(self) weakself = self;
        cell.onClickItemButtonBlock = ^(NSIndexPath *indexPath) {
            [weakself dismiss:^{
                if(weakself.itemBlock){
                    weakself.itemBlock(indexPath.row);
                }
            }];
        };
    }
    [cell configWithTitle:self.items[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        v.delegate = self;
        v.dataSource = self;
        v.separatorStyle = UITableViewCellSeparatorStyleNone;
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
        _tableView = v;
    }
    return _tableView;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setTitle:(self.cancelTitle?self.cancelTitle:@"取消") forState:UIControlStateNormal];
        v.backgroundColor = [UIColor whiteColor];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDModalThemeConfig sharedConfig].tintColor;
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = v;
    }
    return _cancelButton;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.text = self.alertTitle;
        v.textColor = [UIColor whiteColor];
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0.0)];
        v.numberOfLines = 0;
        v.attributedText = self.alertMessageAttr;
//        v.backgroundColor = DD_COLOR_Random();
        _messageLabel = v;
    }
    return _messageLabel;
}

@end
