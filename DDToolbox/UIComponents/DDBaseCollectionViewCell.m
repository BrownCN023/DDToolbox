//
//  DDBaseCollectionViewCell.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseCollectionViewCell.h"

@implementation DDBaseCollectionViewCell

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setupData{
    
}
- (void)setupNoti{}
- (void)setupSubviews{}
- (void)setupLayout{}

- (void)bindViewModel:(DDCollectionItemViewModel *)viewModel indexPath:(NSIndexPath *)indexPath{
    self.viewModel = viewModel;
    self.indexPath = indexPath;
}
- (void)configWithDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    self.dataModel = dataModel;
    self.indexPath = indexPath;
}

@end
