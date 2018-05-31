//
//  DDBaseTableViewHeaderFooterView.h
//  DDToolboxExample
//
//  Created by brown on 2018/5/2.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTableSectionViewModel.h"

@interface DDBaseTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong) DDTableSectionViewModel * viewModel;
@property (nonatomic,strong) id dataModel;
@property (nonatomic,assign) NSInteger section;

- (void)bindingViewModel:(DDTableSectionViewModel *)viewModel section:(NSInteger)section;
- (void)configDataModel:(id)dataModel section:(NSInteger)section;

@end
