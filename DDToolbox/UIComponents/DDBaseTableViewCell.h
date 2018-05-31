//
//  DDBaseTableViewCell.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTableRowViewModel.h"

@interface DDBaseTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) DDTableRowViewModel * viewModel;
@property (nonatomic,strong) id dataModel;

- (void)setupData;
- (void)setupNoti;
- (void)setupSubviews;
- (void)setupLayout;

- (void)bindingViewModel:(DDTableRowViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath;

@end
