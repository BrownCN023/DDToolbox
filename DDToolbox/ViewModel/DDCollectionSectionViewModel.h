//
//  DDCollectionSectionViewModel.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSuperViewModel.h"

@interface DDCollectionSectionViewModel : DDSuperViewModel

@property (nonatomic,copy) NSString * headerIdentifier;
@property (nonatomic,copy) NSString * footerdentifier;
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * footerTitle;
@property (nonatomic,assign) CGSize headerSize;
@property (nonatomic,assign) CGSize footerSize;
@property (nonatomic,assign) CGFloat minimumLineSpacing;
@property (nonatomic,assign) CGFloat minimumInteritemSpacing;
@property (nonatomic,assign) UIEdgeInsets sectionInset;
@property (nonatomic,strong) NSMutableArray * rowArray;

@property (nonatomic,copy) void (^onClickSectionHeaderViewBlock)(NSInteger section,DDSuperViewModel * viewModel);
@property (nonatomic,copy) void (^onClickSectionFooterViewBlock)(NSInteger section,DDSuperViewModel * viewModel);

@end
