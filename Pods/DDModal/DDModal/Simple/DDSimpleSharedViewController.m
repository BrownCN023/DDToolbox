//
//  DDSimpleSharedViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleSharedViewController.h"

#define DDSimpleSharedItemSpace 10

@interface DDSimpleSharedCollectionCell : UICollectionViewCell

@property (nonatomic,assign) BOOL hasAnimated;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * iconButton;

- (void)configWithTitle:(NSString *)title icon:(NSString *)icon indexPath:(NSIndexPath *)indexPath;
- (void)enterAnimation:(NSIndexPath *)indexPath;

@end

@implementation DDSimpleSharedCollectionCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupData{}
- (void)setupNoti{}
- (void)setupSubviews{
    [self.contentView addSubview:self.iconButton];
    [self.contentView addSubview:self.titleLabel];
}
- (void)setupLayout{
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self.titleLabel.mas_top);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-15);
    }];
}

- (void)configWithTitle:(NSString *)title icon:(NSString *)icon indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.titleLabel.text = title;
    [self.iconButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)enterAnimation:(NSIndexPath *)indexPath{
    if(self.hasAnimated){
        return;
    }
    if(indexPath.row >= 5){
        self.hasAnimated = YES;
        return;
    }
    self.hasAnimated = YES;
    CGRect newFrame = self.frame;
    self.alpha = 0;
    self.frame = CGRectMake(newFrame.origin.x, 80, newFrame.size.width, newFrame.size.height);
    [UIView animateWithDuration:0.8 delay:(indexPath.row*0.05) usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha = 1;
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.font = [UIFont systemFontOfSize:12];
        v.textAlignment = NSTextAlignmentCenter;
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UIButton *)iconButton{
    if(!_iconButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
//        v.contentMode = UIViewContentModeScaleAspectFit;
        _iconButton = v;
    }
    return _iconButton;
}

@end


@interface DDSimpleSharedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
}
@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic,strong) NSArray * items;
@property (nonatomic,strong) NSArray * otherItems;
@property (nonatomic,copy) NSString * titleKeyPath;
@property (nonatomic,copy) NSString * iconKeyPath;
@property (nonatomic,copy) NSString * cancel;
@property (nonatomic,copy) void (^clickItemBlock)(NSInteger itemIndex,id item);
@property (nonatomic,copy) void (^cancelBlock)(void);

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionView * collectionView2;
@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UIButton * cancelButton;


@end

@implementation DDSimpleSharedViewController

+ (DDSimpleSharedViewController *)showShared:(NSArray *)items
                                titleKeyPath:(NSString *)titleKeyPath
                                 iconKeyPath:(NSString *)iconKeyPath
                            onClickItemBlock:(void (^)(NSInteger itemIndex,id item))clickItemBlock
                                      cancel:(NSString *)cancel
                               onCancelBlock:(void (^)(void))cancelBlock{
    DDSimpleSharedViewController * vctl = [[DDSimpleSharedViewController alloc] init];
    vctl.items = items;
    vctl.titleKeyPath = titleKeyPath;
    vctl.iconKeyPath = iconKeyPath;
    vctl.clickItemBlock = clickItemBlock;
    vctl.cancel = cancel;
    vctl.cancelBlock = cancelBlock;
    
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

- (CGFloat)popMarginBottom{
    return 0.0f;
}

- (CGFloat)popMarginLeft{
    return 0;
}

- (CGFloat)popMarginRight{
    return 0;
}

- (CGSize)cornerSize{
    return CGSizeZero;
}

- (CGFloat)topHeight{
    return 0;
}

- (CGFloat)bottomHeight{
    return 50;
}

- (CGFloat)contentHeight{
    return _itemSize.height*2;
}


- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = _itemSize;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return layout;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
    CGFloat itemWidth = floor((DDModal_ScreenWidth-10)/4.5);
    _itemSize = CGSizeMake(itemWidth, itemWidth*1.5);
    self.otherItems = @[@{@"title":@"系统分享",@"icon":@"DDModal.bundle/shared-qqzone.png"},@{@"title":@"短信",@"icon":@"DDModal.bundle/shared-qqzone.png"},@{@"title":@"邮件",@"icon":@"DDModal.bundle/shared-qqzone.png"},@{@"title":@"复制链接",@"icon":@"DDModal.bundle/shared-qqzone.png"}];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.collectionView2];
    [self.contentView addSubview:self.lineView];
    
    [self.collectionView registerClass:[DDSimpleSharedCollectionCell class] forCellWithReuseIdentifier:@"DDSimpleSharedCollectionCell"];
    [self.collectionView2 registerClass:[DDSimpleSharedCollectionCell class] forCellWithReuseIdentifier:@"DDSimpleSharedCollectionCell"];
    
    [self.bottomView addSubview:self.cancelButton];
    
    UIView * bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
    [self.bottomView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setupLayout{
    [super setupLayout];
    __weak typeof(self) weakself = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(weakself.itemSize.height);
    }];
    [self.collectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(weakself.itemSize.height);
        make.top.equalTo(weakself.collectionView.mas_bottom);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(weakself.collectionView.mas_bottom);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.collectionView){
        return self.items.count;
    }else{
        return self.otherItems.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDSimpleSharedCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDSimpleSharedCollectionCell" forIndexPath:indexPath];
    id item = nil;
    NSString * title = nil;
    NSString * icon = nil;
    if(collectionView == self.collectionView){
        item = self.items[indexPath.row];
        title = [item valueForKeyPath:self.titleKeyPath];
        icon = [item valueForKeyPath:self.iconKeyPath];
    }else{
        item = self.otherItems[indexPath.row];
        title = [item valueForKeyPath:@"title"];
        icon = [item valueForKeyPath:@"icon"];
    }
    [cell configWithTitle:title icon:icon indexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(DDSimpleSharedCollectionCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell enterAnimation:indexPath];
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionView * v = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self collectionViewLayout]];
        v.backgroundColor = [UIColor whiteColor];
        v.delegate = self;
        v.dataSource = self;
        v.showsHorizontalScrollIndicator = NO;
        v.alwaysBounceHorizontal = YES;
        _collectionView = v;
    }
    return _collectionView;
}

- (UICollectionView *)collectionView2{
    if(!_collectionView2){
        UICollectionView * v = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self collectionViewLayout]];
        v.backgroundColor = [UIColor whiteColor];
        v.delegate = self;
        v.dataSource = self;
        v.showsHorizontalScrollIndicator = NO;
        v.alwaysBounceHorizontal = YES;
        _collectionView2 = v;
    }
    return _collectionView2;
}

- (UIView *)lineView{
    if(!_lineView){
        UIView * v = [[UIView alloc] init];
        v.backgroundColor = DDModal_COLOR_Hex(0xE6E6E6);
        _lineView = v;
    }
    return _lineView;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setTitle:self.cancel forState:UIControlStateNormal];
        v.tintColor = [UIColor darkTextColor];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _cancelButton = v;
    }
    return _cancelButton;
}

@end
