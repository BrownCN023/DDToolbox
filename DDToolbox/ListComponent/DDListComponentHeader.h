//
//  DDListComponentHeader.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#ifndef DDListComponentHeader_h
#define DDListComponentHeader_h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDListComponentViewState) {
    DDListComponentViewStateNone = 0,   //无状态(初始化/默认状态)
    DDListComponentViewStateEmpty,      //空
    DDListComponentViewStateNoNetwork,  //无网络
    DDListComponentViewStateLoadingFirstPage, //加载第一页数据
    DDListComponentViewStateLoadingNextPage,  //加载下一页数据
    DDListComponentViewStateLoadingEnd,       //加载完成
    DDListComponentViewStateLoadingFailed,    //加载失败
    DDListComponentViewStateLoadingError,     //加载异常
    DDListComponentViewStateLoadingNoData     //加载完成且无数据
};

@protocol DDTableRowProtocol <NSObject>
@required
- (NSString *)cellIdentifier;
- (CGFloat)cellRowHeight;
@optional
- (void)createLayout;
@end

@protocol DDTableSectionProtocol <NSObject>
@required
- (NSMutableArray<DDTableRowProtocol> *)rowArray;
@optional
- (NSString *)headerIdentifier;
- (NSString *)footerIdentifier;
- (CGFloat)headerHeight;
- (CGFloat)footerHeight;
- (void)createLayout;
@end

@protocol DDTableCellProtocol <NSObject>
@required
- (void)setCellData:(id)cellData
          indexPath:(NSIndexPath *)indexPath;
@optional
@property (nonatomic,weak) id eventHandler;
@end

@protocol DDTableSectionHeaderFooterProtocol <NSObject>
@optional
@property (nonatomic,weak) id eventHandler;
- (void)setSectionModel:(id<DDTableSectionProtocol>)sectionModel
                section:(NSInteger)section;
@end





@protocol DDCollectionItemProtocol <NSObject>
@required
- (NSString *)cellIdentifier;
- (CGSize)cellItemSize;
@optional
- (void)createLayout;
@end

@protocol DDCollectionSectionProtocol <NSObject>
@required
- (NSMutableArray<DDCollectionItemProtocol> *)itemArray;
@optional
- (UIEdgeInsets)sectionInset;
- (CGFloat)minimumLineSpacing;
- (CGFloat)minimumInteritemSpacing;
- (NSString *)headerIdentifier;
- (NSString *)footerIdentifier;
- (CGSize)headerSize;
- (CGSize)footerSize;
- (void)createLayout;
@end

@protocol DDCollectionCellProtocol <NSObject>
@required
- (void)setCellData:(id)cellData
          indexPath:(NSIndexPath *)indexPath;
@optional
@property (nonatomic,weak) id eventHandler;
@end

@protocol DDCollectionReusableViewProtocol <NSObject>
@optional
@property (nonatomic,weak) id eventHandler;
- (void)setSectionModel:(id<DDCollectionSectionProtocol>)sectionModel
              indexPath:(NSIndexPath *)indexPath;
@end

#endif /* DDListComponentHeader_h */
