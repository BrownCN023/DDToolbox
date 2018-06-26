//
//  DDSimpleConfirmViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDModalConfig.h"
#import "NSString+DDModal.h"

@interface DDSimpleConfirmViewController : DDModalAlertViewController

+ (id)showAlert:(NSString *)title
        message:(NSString *)message
  onCancelBlock:(void (^)(void))cancelBlock
 onConfirmBlock:(void (^)(void))confirmBlock;

+ (id)showAlert:(NSString *)title
        message:(NSString *)message
         cancel:(NSString *)cancel
        confirm:(NSString *)confirm
  onCancelBlock:(void (^)(void))cancelBlock
 onConfirmBlock:(void (^)(void))confirmBlock;

@end
