//
//  DDTableViewProxy.m
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDTableViewProxy.h"

@implementation DDTableSectionViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rowArray = [NSMutableArray<DDTableRowProtocol> new];
    }
    return self;
}
@end





@implementation DDTableViewProxy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionArray = [NSMutableArray<DDTableSectionProtocol> new];
    }
    return self;
}
#pragma mark - UITableViewDelegate/UITableVeiwDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[section];
    return sectionModel.rowArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
    id<DDTableRowProtocol> rowModel = sectionModel.rowArray[indexPath.item];
    return rowModel.cellRowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
    id<DDTableRowProtocol> rowModel = sectionModel.rowArray[indexPath.item];
    UITableViewCell<DDTableCellProtocol> * cell = [tableView dequeueReusableCellWithIdentifier:rowModel.cellIdentifier forIndexPath:indexPath];
    [cell setCellData:rowModel indexPath:indexPath];
    if([cell respondsToSelector:@selector(setEventHandler:)]){
        cell.eventHandler = self.eventHandler;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[section];
    if([sectionModel respondsToSelector:@selector(headerHeight)]){
        return sectionModel.headerHeight;
    }else{
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[section];
    if([sectionModel respondsToSelector:@selector(footerHeight)]){
        return sectionModel.footerHeight;
    }else{
        return 0.01;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[section];
    if([sectionModel respondsToSelector:@selector(headerIdentifier)]){
        UITableViewHeaderFooterView<DDTableSectionHeaderFooterProtocol> * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.headerIdentifier];
        if([header respondsToSelector:@selector(setEventHandler:)]){
            header.eventHandler = self.eventHandler;
        }
        if([header respondsToSelector:@selector(setSectionModel:section:)]){
            [header setSectionModel:sectionModel section:section];
        }
        return header;
    }
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    id<DDTableSectionProtocol> sectionModel = self.sectionArray[section];
    if([sectionModel respondsToSelector:@selector(footerIdentifier)]){
        UITableViewHeaderFooterView<DDTableSectionHeaderFooterProtocol> * footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.footerIdentifier];
        if([footer respondsToSelector:@selector(setEventHandler:)]){
            footer.eventHandler = self.eventHandler;
        }
        if([footer respondsToSelector:@selector(setSectionModel:section:)]){
            [footer setSectionModel:sectionModel section:section];
        }
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(tableViewEvent:didSelectAtIndexPath:sectionModel:rowModel:)]){
        id<DDTableSectionProtocol> sectionModel = self.sectionArray[indexPath.section];
        id<DDTableRowProtocol> rowModel = sectionModel.rowArray[indexPath.item];
        [self.eventDelegate tableViewEvent:tableView
                     didSelectAtIndexPath:indexPath
                             sectionModel:sectionModel
                                 rowModel:rowModel];
    }
}

@end
