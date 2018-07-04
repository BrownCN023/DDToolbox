//
//  DDTableSectionViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"

@interface DDTableSectionViewModel : DDViewModel

@property (nonatomic,copy) NSString * headerIdentifier;
@property (nonatomic,copy) NSString * footerIdentifier;
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * footerTitle;
@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;
@property (nonatomic,strong) NSMutableArray * rowArray;

@property (nonatomic,copy) void (^onClickSectionHeaderViewBlock)(NSInteger section,DDViewModel * viewModel);
@property (nonatomic,copy) void (^onClickSectionFooterViewBlock)(NSInteger section,DDViewModel * viewModel);

@end
