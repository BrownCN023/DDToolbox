//
//  DDSimpleInputViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDModalConfig.h"

@interface DDSimpleInputViewController : DDModalAlertViewController

@property (nonatomic,strong,readonly) UITextField * textField;

+ (id)showAlert:(NSString *)title
           text:(NSString *)text
    placeholder:(NSString *)placeholder
  onCancelBlock:(void (^)(void))cancelBlock
  onSubmitBlock:(void (^)(NSString * text))submitBlock
onValidationBlock:(BOOL (^)(NSString * text))validationBlock;

+ (id)showAlert:(NSString *)title
           text:(NSString *)text
    placeholder:(NSString *)placeholder
         cancel:(NSString *)cancel
        confirm:(NSString *)confirm
  onCancelBlock:(void (^)(void))cancelBlock
  onSubmitBlock:(void (^)(NSString * text))submitBlock
onValidationBlock:(BOOL (^)(NSString * text))validationBlock;

@end
