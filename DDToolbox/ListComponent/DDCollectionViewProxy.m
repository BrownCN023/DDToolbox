//
//  DDCollectionViewProxy.m
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDCollectionViewProxy.h"

@implementation DDCollectionSectionViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemArray = [NSMutableArray<DDCollectionItemProtocol> new];
    }
    return self;
}
- (UIEdgeInsets)sectionInset{
    return UIEdgeInsetsZero;
}
- (CGFloat)minimumLineSpacing{
    return 0;
}
- (CGFloat)minimumInteritemSpacing{
    return 0;
}
- (CGSize)headerSize{
    return CGSizeZero;
}
- (CGSize)footerSize{
    return CGSizeZero;
}
- (NSString *)headerIdentifier{
    return nil;
}
- (NSString *)footerIdentifier{
    return nil;
}
@end




@implementation DDCollectionViewProxy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionArray = [NSMutableArray<DDCollectionSectionProtocol> new];
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
    id<DDCollectionItemProtocol> itemModel = sectionModel.itemArray[indexPath.item];
    UICollectionViewCell<DDCollectionCellProtocol> * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemModel.cellIdentifier forIndexPath:indexPath];
    [cell setCellData:itemModel indexPath:indexPath];
    if([cell respondsToSelector:@selector(setEventHandler:)]){
        cell.eventHandler = self.eventHandler;
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
    if(sectionModel.headerIdentifier && [kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView<DDCollectionReusableViewProtocol> * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionModel.headerIdentifier forIndexPath:indexPath];
        if([header respondsToSelector:@selector(setEventHandler:)]){
            header.eventHandler = self.eventHandler;
        }
        if(header && [header respondsToSelector:@selector(setSectionModel:indexPath:)]){
            [header setSectionModel:sectionModel indexPath:indexPath];
        }
        return header;
    }else if (sectionModel.footerIdentifier && [kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView<DDCollectionReusableViewProtocol> * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionModel.footerIdentifier forIndexPath:indexPath];
        if([footer respondsToSelector:@selector(setEventHandler:)]){
            footer.eventHandler = self.eventHandler;
        }
        if(footer && [footer respondsToSelector:@selector(setSectionModel:indexPath:)]){
            [footer setSectionModel:sectionModel indexPath:indexPath];
        }
        return footer;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
    id<DDCollectionItemProtocol> itemModel = sectionModel.itemArray[indexPath.item];
    return itemModel.cellItemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.sectionInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.headerSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.footerSize;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(collectionViewEvent:didSelectAtIndexPath:sectionModel:itemModel:)]){
        id<DDCollectionSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
        id<DDCollectionItemProtocol> itemModel = sectionModel.itemArray[indexPath.item];
        [self.eventDelegate collectionViewEvent:collectionView
                           didSelectAtIndexPath:indexPath
                                   sectionModel:sectionModel
                                      itemModel:itemModel];
    }
}

@end
