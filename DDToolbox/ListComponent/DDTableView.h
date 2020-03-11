//
//  DDTableView.h
//  DDListComponentsDemo
//  
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTableViewProxy.h"

NS_ASSUME_NONNULL_BEGIN

@class DDTableView;
typedef DDTableView * _Nonnull (^DDTableSetupViewProxyBlock)(DDTableViewProxy * viewProxy);

@interface DDTableView : UITableView

@property (nonatomic,strong,readonly) DDTableViewProxy * viewProxy;
@property (nonatomic,strong,readonly) DDTableSetupViewProxyBlock setupViewProxyBlock;

+ (DDTableView *)createPlainTableView:(void (^)(DDTableView * _Nonnull tableView))configBlock;
+ (DDTableView *)createGroupedTableView:(void (^)(DDTableView * _Nonnull tableView))configBlock;

@end

NS_ASSUME_NONNULL_END
