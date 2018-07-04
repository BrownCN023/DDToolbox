//
//  DDSimpleSharedViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"

@interface DDSimpleSharedViewController : DDModalAlertViewController

+ (DDSimpleSharedViewController *)showShared:(NSArray *)items
                                titleKeyPath:(NSString *)titleKeyPath
                                 iconKeyPath:(NSString *)iconKeyPath
                            onClickItemBlock:(void (^)(NSInteger itemIndex,id item))clickItemBlock
                                      cancel:(NSString *)cancel
                               onCancelBlock:(void (^)(void))cancelBlock;

@end
