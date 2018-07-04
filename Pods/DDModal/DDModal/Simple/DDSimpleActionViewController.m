//
//  DDSimpleActionViewController.m
//  DDTooboxDemo
//
//  Created by brown on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleActionViewController.h"
#import "NSString+DDModal.h"
#import "UIButton+DDModalHighlightColor.h"
#define DDSimpleActionItemHeight 52.0f


@interface DDSimpleActionItemCell : UITableViewCell

@property (nonatomic,strong) UILabel * itemLabel;
@property (nonatomic,strong) UIView * topLineView;
@property (nonatomic,strong) NSIndexPath * indexPath;

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




@interface DDSimpleActionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * cancelButton;

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;

@property (nonatomic,copy) NSString * alertTitle;
@property (nonatomic,copy) NSAttributedString * alertTitleAttr;
@property (nonatomic,copy) NSString * alertMessage;
@property (nonatomic,copy) NSAttributedString * alertMessageAttr;

@property (nonatomic,assign) CGFloat alertTitleHeight;
@property (nonatomic,assign) CGFloat alertMessageHeight;



@property (nonatomic,copy) NSString * cancelTitle;
@property (nonatomic,copy) NSArray * items;
@property (nonatomic,copy) void (^cancelBlock)(void);
@property (nonatomic,copy) void (^itemBlock)(NSInteger itemIndex);

@end

@implementation DDSimpleActionViewController

+ (id)showAction:(NSString *)title
         message:(NSString *)message
   onCancelBlock:(void (^)(void))cancelBlock
otherButtonItems:(NSArray<NSString *> *)otherButtonItems
onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock
{
    return [self showAction:title
                    message:message
          cancelButtonTitle:@"取消"
              onCancelBlock:cancelBlock
           otherButtonItems:otherButtonItems
           onClickItemBlock:clickItemBlock];
}

+ (id)showAction:(NSString *)title
         message:(NSString *)message
cancelButtonTitle:(NSString *)cancelButtonTitle
   onCancelBlock:(void (^)(void))cancelBlock
otherButtonItems:(NSArray<NSString *> *)otherButtonItems
onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock
{
    DDSimpleActionViewController * vctl = [[[self class] alloc] init];
    vctl.alertTitle = title;
    vctl.cancelTitle = cancelButtonTitle;
    vctl.items = otherButtonItems;
    vctl.cancelBlock = cancelBlock;
    vctl.itemBlock = clickItemBlock;
    
    
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

- (CGFloat)topHeight{
    CGFloat targetTopHeight = self.titleMarginTop + self.alertTitleHeight +self.titleMarginBottom + self.messageMarginTop + self.alertMessageHeight + self.messageMarginBottom;
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
        return 5.0f;
    }
    return 18.0f;
}
- (CGFloat)messageMarginBottom{
    if(self.alertMessageHeight <= 0){
        return 0.0;
    }
    return 18.0f;
}

- (CGFloat)bottomHeight{
    return DDSimpleActionItemHeight+20;
}

- (CGFloat)contentHeight{
    CGFloat totalContentHeight = self.items.count*DDSimpleActionItemHeight;
    CGFloat maxHeight = DDModal_ScreenHeight-DDSimpleActionItemHeight;
    BOOL scrollEnabled = NO;
    if(totalContentHeight+self.topHeight+self.bottomHeight > maxHeight){
        totalContentHeight = maxHeight-(self.topHeight+self.bottomHeight);
        scrollEnabled = YES;
    }
    self.tableView.scrollEnabled = scrollEnabled;
    return totalContentHeight;
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
    [self.topView addSubview:self.messageLabel];
    [self.contentView addSubview:self.tableView];
    [self.bottomView addSubview:self.cancelButton];
    
    [self.tableView registerClass:[DDSimpleActionItemCell class] forCellReuseIdentifier:@"DDSimpleActionItemCell"];
    if(self.items.count > 0){
        [self.contentView modalLayerCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.popMarginLeft-self.popMarginRight, self.contentHeight) cornerSize:self.cornerSize];
    }else{
        [self.topView modalLayerCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRect:CGRectMake(0, 0, DDModal_ScreenWidth-self.popMarginLeft-self.popMarginRight, self.topHeight) cornerSize:self.cornerSize];
    }
    [self.cancelButton modalLayerCorners:(UIRectCornerAllCorners) cornerRect:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-self.popMarginLeft-self.popMarginRight, self.bottomHeight-20) cornerSize:self.cornerSize];
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
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(10);
        make.left.equalTo(self.bottomView).offset(0);
        make.right.equalTo(self.bottomView).offset(0);
        make.bottom.equalTo(self.bottomView).offset(-10);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.contentView);
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
    
    [cell configWithTitle:self.items[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss:^{
        if(self.itemBlock){
            self.itemBlock(indexPath.row);
        }
    }];
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
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        [v setTitle:(self.cancelTitle?self.cancelTitle:@"取消") forState:UIControlStateNormal];
        v.backgroundColor = [UIColor whiteColor];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        v.tintColor = [DDModalThemeConfig sharedConfig].tintColor;
        [v setTitleColor:[DDModalThemeConfig sharedConfig].tintColor forState:UIControlStateNormal];
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        v.highlightColor = DDModal_COLOR_Hex(0xE6E6E6);
        _cancelButton = v;
    }
    return _cancelButton;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.numberOfLines = 0;
        v.attributedText = self.alertTitleAttr;
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if(!_messageLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0.0)];
        v.numberOfLines = 0;
        v.attributedText = self.alertMessageAttr;
        //v.backgroundColor = DDModal_COLOR_Hex(0xf7c32f);
        _messageLabel = v;
    }
    return _messageLabel;
}

@end
