//
//  DDBaseTableViewHeaderFooterView.m
//  DDToolboxExample
//
//  Created by brown on 2018/5/2.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseTableViewHeaderFooterView.h"

@implementation DDBaseTableViewHeaderFooterView

- (void)bindingViewModel:(DDTableSectionViewModel *)viewModel section:(NSInteger)section{
    self.viewModel = viewModel;
    self.section = section;
}

- (void)configDataModel:(id)dataModel section:(NSInteger)section{
    self.dataModel = dataModel;
    self.section = section;
}

@end
