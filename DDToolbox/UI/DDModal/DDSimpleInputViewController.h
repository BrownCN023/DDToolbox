//
//  DDSimpleInputViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleAlertViewController.h"

@interface DDSimpleInputViewController : DDSimpleAlertViewController

@property (nonatomic,strong,readonly) UITextField * textField;

+ (void)showAlert:(NSString *)title text:(NSString *)text placeholder:(NSString *)placeholder onCancelBlock:(void (^)(void))cancelBlock onSubmitBlock:(void (^)(NSString * text))submitBlock onValidationBlock:(BOOL (^)(NSString * text))validationBlock;

@end
