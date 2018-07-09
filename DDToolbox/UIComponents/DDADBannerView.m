//
//  DDADBannerView.m
//  iOSDDMao
//
//  Created by TongAn001 on 2018/7/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDADBannerView.h"
#import <Masonry/Masonry.h>
#import "DDToolbox.h"


@implementation DDADBannerCell

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupNoti{
    [super setupNoti];
}
- (void)setupSubviews{
    [super setupSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel1];
    [self.contentView addSubview:self.titleLabel2];
}
- (void)setupLayout{
    [super setupLayout];
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.titleLabel2.mas_top).priorityLow();
        make.height.equalTo(self.titleLabel2);
    }];
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleLabel1.mas_bottom).priorityLow();
    }];
}

- (UILabel *)titleLabel1{
    if(!_titleLabel1){
        UILabel * v = [[UILabel alloc] init];
        v.text = @"黑金加持\"Nike\"泡，年底来袭!";
        v.font = [UIFont systemFontOfSize:14];
        _titleLabel1 = v;
    }
    return _titleLabel1;
}

- (UILabel *)titleLabel2{
    if(!_titleLabel2){
        UILabel * v = [[UILabel alloc] init];
        v.text = @"放松身心的家装风格，你喜欢哪一款？";
        v.font = [UIFont systemFontOfSize:14];
        _titleLabel2 = v;
    }
    return _titleLabel2;
}

@end

@implementation DDADBannerView

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupNoti{
    [super setupNoti];
}
- (void)setupSubviews{
    [super setupSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.adImgView];
    [self addSubview:self.adItemLoopView];
    
    [self.adItemLoopView startLoopScroll];
}
- (void)setupLayout{
    [super setupLayout];
    [self.adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.equalTo(self.adImgView.mas_height);
    }];
    [self.adItemLoopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.adImgView.mas_right).offset(10);
        make.top.mas_equalTo(0);
        make.right.bottom.mas_equalTo(0);
    }];
}

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    return layout;
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.adItemLoopView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDADBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDADBannerCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (DDAutoLoopCollectionView *)adItemLoopView{
    if(!_adItemLoopView){
        DDAutoLoopCollectionView * v = [[DDAutoLoopCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        v.pagingEnabled = YES;
        v.rollingInterval = 3;
        if(@available(iOS 11.0, *)){
            v.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        v.delegate = self;
        v.dataSource = self;
        [v regCellClassWithClazz:[DDADBannerCell class]];
        _adItemLoopView = v;
    }
    return _adItemLoopView;
}

- (UIImageView *)adImgView{
    if(!_adImgView){
        UIImageView * v = [[UIImageView alloc] init];
        v.image = [UIImage imageNamed:@"头条.png"];
        _adImgView = v;
    }
    return _adImgView;
}

@end
