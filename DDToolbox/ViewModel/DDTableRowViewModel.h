//
//  DDTableRowViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"

@interface DDTableRowViewModel : DDViewModel

@property (nonatomic,assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic,assign) CGFloat rowHeight;  //default 50.0f
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * footerTitle;
@property (nonatomic,copy) NSString * cellIdentifier;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,copy) void (^onSelectedRowDataModelBlock)(NSIndexPath * indexPath,id dataModel);
@property (nonatomic,copy) void (^onSelectedRowViewModelBlock)(NSIndexPath * indexPath,DDViewModel * viewModel);

@end
