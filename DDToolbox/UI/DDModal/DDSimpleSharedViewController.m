//
//  DDSimpleSharedViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleSharedViewController.h"
#import "DDLoopCollectionView.h"
#import "DDMacro.h"
#import "DDBaseCollectionViewCell.h"
#import "DDXib.h"
#import <Masonry/Masonry.h>
#import "DDLayoutButton.h"
#import "UIView+DDBorder.h"

@interface DDSimpleSharedItemCell : DDBaseCollectionViewCell

@property (nonatomic,strong) DDLayoutButton * itemButton;

@end

@implementation DDSimpleSharedItemCell

- (void)setupSubviews{
    [super setupSubviews];
    //self.contentView.backgroundColor = DD_COLOR_Random();
    [self.contentView addSubview:self.itemButton];
}

- (void)setupLayout{
    [super setupLayout];
    [self.itemButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView);
    }];
}

- (DDLayoutButton *)itemButton{
    if(!_itemButton){
        DDLayoutButton * v = [DDLayoutButton buttonWithType:UIButtonTypeCustom];
        v.titleImageInterval = 8;
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/shared-qq.png"] forState:UIControlStateNormal];
        [v setTitleColor:[DDToolboxThemeConfig sharedConfig].themeColor forState:UIControlStateNormal];
        v.titleLabel.font = [UIFont systemFontOfSize:12];
        _itemButton = v;
    }
    return _itemButton;
}
- (void)configWithDataModel:(NSDictionary *)dataModel indexPath:(NSIndexPath *)indexPath{
    [_itemButton setTitle:dataModel[@"title"] forState:UIControlStateNormal];
    [_itemButton setImage:[UIImage imageNamed:dataModel[@"image"]] forState:UIControlStateNormal];
}

@end

@interface DDSimpleSharedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,strong) NSMutableArray * items;

@property (nonatomic,strong) UIButton * cancelButton;

@end

@implementation DDSimpleSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (DDSuperAlertAnimation)showAlertAnimation{
    return DDSuperAlertAnimationBottom;
}
- (DDSuperAlertAnimation)hideAlertAnimation{
    return DDSuperAlertAnimationBottom;
}

- (CGFloat)springDamping{return 0.9;}
- (CGFloat)alertMarginLeft{return 0;}
- (CGFloat)alertMarginRight{return 0;}
- (CGFloat)alertMarginBottom{return 0;}
- (CGSize)cornerSize{return CGSizeZero;}
- (CGFloat)topHeight{return 0;}
- (CGFloat)bottomHeight{return 55;}
- (CGFloat)contentHeight{return 120;}
- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
    self.itemSize = CGSizeMake(DD_ScreenWidth/4.5, 100);
    self.items = [NSMutableArray new];
    [self.items addObject:@{@"title":@"微信",@"image":@"DDToolbox.bundle/shared-wechat.png"}];
    [self.items addObject:@{@"title":@"朋友圈",@"image":@"DDToolbox.bundle/shared-wechatcircle.png"}];
    [self.items addObject:@{@"title":@"微博",@"image":@"DDToolbox.bundle/shared-weibo.png"}];
    [self.items addObject:@{@"title":@"QQ好友",@"image":@"DDToolbox.bundle/shared-qq.png"}];
    [self.items addObject:@{@"title":@"QQ空间",@"image":@"DDToolbox.bundle/shared-qqzone.png"}];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView regCellClassWithClazz:[DDSimpleSharedItemCell class]];
    [self.bottomView addSubview:self.cancelButton];
    [self.cancelButton simpleBorder:DDBorderTypeTop width:0.5 color:DD_COLOR_Hex(0xE6E6E6)];
}
- (void)setupLayout{
    [super setupLayout];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(7.5);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(self.itemSize.height);
    }];
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}

- (void)clickCancelButton:(UIButton *)sender{
    [self dismiss:nil];
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDSimpleSharedItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDSimpleSharedItemCell" forIndexPath:indexPath];
    [cell configWithDataModel:self.items[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionView * v = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        v.backgroundColor = [UIColor whiteColor];//DD_COLOR_RGB(230, 230, 230);
        v.delegate = self;
        v.dataSource = self;
        v.alwaysBounceHorizontal = YES;
//        v.pagingEnabled = YES;
        v.showsHorizontalScrollIndicator = NO;
        _collectionView = v;
    }
    return _collectionView;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        v.backgroundColor = [UIColor whiteColor];
        [v setTitle:@"取消" forState:UIControlStateNormal];
        v.tintColor = [DDToolboxThemeConfig sharedConfig].themeColor;
        [v addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = v;
    }
    return _cancelButton;
}

@end
