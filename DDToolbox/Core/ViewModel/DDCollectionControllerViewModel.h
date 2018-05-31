//
//  DDCollectionControllerViewModel.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@class DDCollectionControllerViewModel;
@protocol DDCollectionControllerViewModelDelegate <DDControllerViewModelDelegate>

@optional
- (void)collectionControllerViewModelDidChanged:(DDCollectionControllerViewModel *)viewModel;
- (void)collectionControllerViewModelDidChanged:(DDCollectionControllerViewModel *)viewModel section:(NSInteger)section;
- (void)collectionControllerViewModelDidChanged:(DDCollectionControllerViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

@end

@interface DDCollectionControllerViewModel : DDControllerViewModel

@end
