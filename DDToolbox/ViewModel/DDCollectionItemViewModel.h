//
//  DDCollectionItemViewModel.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSuperViewModel.h"

@interface DDCollectionItemViewModel : DDSuperViewModel

@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,copy) NSString * cellIdentifier;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,copy) void (^onSelectedItemBlock)(NSIndexPath * indexPath,id dataModel);
@property (nonatomic,copy) void (^onSelectedItemViewModelBlock)(NSIndexPath * indexPath,DDSuperViewModel * viewModel);

@end
