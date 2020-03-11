//
//  DDTableViewProxy.h
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDListComponentHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDTableViewEventDelegate <NSObject>

@optional
- (void)tableViewEvent:(UITableView *)tableView
  didSelectAtIndexPath:(NSIndexPath *)indexPath
          sectionModel:(id<DDTableSectionProtocol>)sectionModel
              rowModel:(id<DDTableRowProtocol>)rowModel;
@end


@interface DDTableSectionViewModel : NSObject<DDTableSectionProtocol>
@property (nonatomic,strong) NSMutableArray<DDTableRowProtocol> * rowArray;
@end

@interface DDTableViewProxy : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray<DDTableSectionProtocol> * sectionArray;
@property (nonatomic,weak) id<DDTableViewEventDelegate> eventDelegate;
@property (nonatomic,weak) id eventHandler;
@end

NS_ASSUME_NONNULL_END
