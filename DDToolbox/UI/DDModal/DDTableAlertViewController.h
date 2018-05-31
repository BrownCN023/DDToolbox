//
//  DDTableAlertViewController.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"

@interface DDTableAlertViewController : DDSimpleAlertViewController

@property (nonatomic,strong,readonly) UITableView * tableView;
@property (nonatomic,strong,readonly) UILabel * titleLabel;
@property (nonatomic,strong,readonly) UIButton * closeButton;
@property (nonatomic,strong,readonly) NSArray * items;

+ (DDTableAlertViewController *)showAlert:(NSString *)title
                                    items:(NSArray *)items
                       onFixedHeightBlock:(CGFloat (^)(void))fixedHeightBlock
                            onCancelBlock:(void (^)(void))cancelBlock
                              onItemBlock:(void (^)(NSInteger itemIndex, id item))itemBlock;

- (CGFloat)cellRowHeight;
- (UITableViewCell *)tableAlertController:(DDTableAlertViewController *)controller tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
