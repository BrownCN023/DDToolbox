//
//  DDTableControllerViewModel.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDControllerViewModel.h"

@class DDTableControllerViewModel;
@protocol DDTableControllerViewModelDelegate <DDControllerViewModelDelegate>

@optional
- (void)tableControllerViewModelDidChanged:(DDTableControllerViewModel *)viewModel;
- (void)tableControllerViewModelDidChanged:(DDTableControllerViewModel *)viewModel section:(NSInteger)section;
- (void)tableControllerViewModelDidChanged:(DDTableControllerViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

@end

@interface DDTableControllerViewModel : DDControllerViewModel

@end
