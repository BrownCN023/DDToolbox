//
//  DDTableRowViewModel.h
//  DDToolboxExample
//
//  Created by brown on 2018/5/2.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSuperViewModel.h"

@interface DDTableRowViewModel : DDSuperViewModel

@property (nonatomic,assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic,assign) CGFloat rowHeight;  //default 50.0f
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * footerTitle;
@property (nonatomic,copy) NSString * cellIdentifier;
@property (nonatomic,copy) void (^onSelectedRowBlock)(NSIndexPath * indexPath,id dataModel);
@property (nonatomic,copy) void (^onSelectedRowViewModelBlock)(NSIndexPath * indexPath,DDSuperViewModel * viewModel);

@end
