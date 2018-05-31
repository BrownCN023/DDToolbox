//
//  DDBaseCollectionHeaderFooterView.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/30.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDBaseCollectionHeaderFooterView.h"

@implementation DDBaseCollectionHeaderFooterView

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

- (void)setupData{
    
}
- (void)setupNoti{
    
}
- (void)setupSubviews{
    
}
- (void)setupLayout{
    
}

- (void)bindingViewModel:(DDCollectionSectionViewModel *)viewModel section:(NSInteger)section{
    self.viewModel = viewModel;
    self.section = section;
}
- (void)configDataModel:(id)dataModel section:(NSInteger)section{
    self.dataModel = dataModel;
    self.section = section;
}

@end
