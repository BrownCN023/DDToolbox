//
//  DDCollectionSectionViewModel.h
//  MVPDemo
//
//  Created by TongAn001 on 2018/7/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDViewModel.h"

@interface DDCollectionSectionViewModel : DDViewModel

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

@property (nonatomic,copy) void (^onClickSectionHeaderViewBlock)(NSInteger section,DDViewModel * viewModel);
@property (nonatomic,copy) void (^onClickSectionFooterViewBlock)(NSInteger section,DDViewModel * viewModel);

@end
