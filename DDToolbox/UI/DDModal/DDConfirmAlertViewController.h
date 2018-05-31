//
//  DDConfirmAlertViewController.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/26.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"

@interface DDConfirmAlertViewController : DDSimpleAlertViewController

+ (void)showAlert:(NSString *)title message:(NSString *)message onCancelBlock:(void (^)(void))cancelBlock onConfirmBlock:(void (^)(void))confirmBlock;

@end
