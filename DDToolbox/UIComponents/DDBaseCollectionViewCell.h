//
//  DDBaseCollectionViewCell.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCollectionItemViewModel.h"

@interface DDBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) id dataModel;
@property (nonatomic,strong) DDCollectionItemViewModel * viewModel;
@property (nonatomic,strong) NSIndexPath * indexPath;

- (void)setupData;
- (void)setupNoti;
- (void)setupSubviews;
- (void)setupLayout;

- (void)bindViewModel:(DDCollectionItemViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;
- (void)configWithDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath;

@end
