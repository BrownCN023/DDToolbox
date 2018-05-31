//
//  DDBaseCollectionHeaderFooterView.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/30.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCollectionSectionViewModel.h"

@interface DDBaseCollectionHeaderFooterView : UICollectionReusableView


@property (nonatomic,strong) DDCollectionSectionViewModel * viewModel;
@property (nonatomic,strong) id dataModel;
@property (nonatomic,assign) NSInteger section;

- (void)bindingViewModel:(DDCollectionSectionViewModel *)viewModel section:(NSInteger)section;
- (void)configDataModel:(id)dataModel section:(NSInteger)section;

- (void)setupData;
- (void)setupNoti;
- (void)setupSubviews;
- (void)setupLayout;

@end
