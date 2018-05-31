//
//  DDTableSectionViewModel.h
//  DDToolboxExample
//
//  Created by brown on 2018/5/2.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTableRowViewModel.h"

@interface DDTableSectionViewModel : DDSimpleViewModel

@property (nonatomic,copy) NSString * headerIdentifier;
@property (nonatomic,copy) NSString * footerIdentifier;
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * footerTitle;
@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;
@property (nonatomic,strong) NSMutableArray * rowArray;

@property (nonatomic,copy) void (^onClickSectionHeaderViewBlock)(NSInteger section,DDSimpleViewModel * viewModel);
@property (nonatomic,copy) void (^onClickSectionFooterViewBlock)(NSInteger section,DDSimpleViewModel * viewModel);


@end
