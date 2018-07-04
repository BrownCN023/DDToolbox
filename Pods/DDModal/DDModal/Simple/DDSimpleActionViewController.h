//
//  DDSimpleActionViewController.h
//  DDTooboxDemo
//
//  Created by brown on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDModalConfig.h"

@interface DDSimpleActionViewController : DDModalAlertViewController

+ (id)showAction:(NSString *)title
         message:(NSString *)message
   onCancelBlock:(void (^)(void))cancelBlock
otherButtonItems:(NSArray<NSString *> *)otherButtonItems
onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

+ (id)showAction:(NSString *)title
         message:(NSString *)message
cancelButtonTitle:(NSString *)cancelButtonTitle
   onCancelBlock:(void (^)(void))cancelBlock
otherButtonItems:(NSArray<NSString *> *)otherButtonItems
onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

@end
