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
           items:(NSArray<NSString *> *)items
   onCancelBlock:(void (^)(void))cancelBlock
     onItemBlock:(void (^)(NSInteger itemIndex))itemBlock;

+ (id)showAction:(NSString *)title
         message:(NSString *)message
          cancel:(NSString *)cancel
           items:(NSArray<NSString *> *)items
   onCancelBlock:(void (^)(void))cancelBlock
     onItemBlock:(void (^)(NSInteger itemIndex))itemBlock;

@end
