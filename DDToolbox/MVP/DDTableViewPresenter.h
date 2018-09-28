//
//  DDTableViewPresenter.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDTableViewPresenter : DDPresenter<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView * tableView;

- (id)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
