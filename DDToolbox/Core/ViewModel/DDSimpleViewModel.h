//
//  DDSimpleViewModel.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSuperViewModel.h"

@class DDSimpleViewModel;
@protocol DDSimpleViewModelDelegate <NSObject>
@optional
- (void)viewModelDidChanged:(DDSimpleViewModel *)viewModel;
@end


@interface DDSimpleViewModel : DDSuperViewModel

@property (nonatomic,weak) id<DDSimpleViewModelDelegate> delegate;

- (id)initWithData:(id)data delegate:(id<DDSimpleViewModelDelegate>)delegate;

@end
