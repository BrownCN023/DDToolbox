//
//  DDCollectionItemViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"

@interface DDCollectionItemViewModel : DDViewModel

@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,copy) NSString * cellIdentifier;
@property (nonatomic,copy) void (^onSelectedItemDataModelBlock)(NSIndexPath * indexPath,id dataModel);
@property (nonatomic,copy) void (^onSelectedItemViewModelBlock)(NSIndexPath * indexPath,DDViewModel * viewModel);

@end
