//
//  DDBaseCollectionViewController.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseCollectionViewController.h"
#import <Masonry/Masonry.h>

@interface DDBaseCollectionViewController ()

@end

@implementation DDBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(150, 150);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    return layout;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupNoti{
    [super setupNoti];
}
- (void)setupNavigation{
    [super setupNavigation];
}
- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.collectionView];
}
- (void)setupLayout{
    [super setupLayout];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)setupRefresh{
    //MJ
}

- (void)endRefreshing{
    //MJ
}

- (void)refreshCollectionView{
    [self.collectionView reloadData];
}
- (void)refreshCollectionViewBySection:(NSInteger)section{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}
- (void)refreshCollectionViewByIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[UICollectionViewCell alloc] init];
}

#pragma mark - Setter/Getter
- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionView * v = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        v.backgroundColor = [UIColor whiteColor];
        v.delegate = self;
        v.dataSource = self;
        v.alwaysBounceVertical = YES;
        _collectionView = v;
    }
    return _collectionView;
}

@end
