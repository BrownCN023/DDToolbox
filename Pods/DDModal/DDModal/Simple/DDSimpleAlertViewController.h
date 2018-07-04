//
//  DDSimpleAlertViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/27.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"
#import "DDModalConfig.h"
#import "NSString+DDModal.h"
#import "UIButton+DDModalHighlightColor.h"

@interface DDSimpleAlertViewController : DDModalAlertViewController

+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                                 buttonTitle:(NSString *)buttonTitle
                               onOkBlock:(void (^)(void))okBlock;

+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                               onCancelBlock:(void (^)(void))cancelBlock
                            onOkBlock:(void (^)(NSInteger itemIndex))okBlock;

+ (DDSimpleAlertViewController *)showConfirm:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelButtonTitle
                               onCancelBlock:(void (^)(void))cancelBlock
                               okButtonTitle:(NSString *)okButtonTitle
                                   onOkBlock:(void (^)(NSInteger itemIndex))okBlock;

+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSString *> *)otherButtonItems
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSString *> *)otherButtonItems
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

+ (DDSimpleAlertViewController *)showAlert:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             onCancelBlock:(void (^)(void))cancelBlock
                          otherButtonItems:(NSArray<NSObject *> *)otherButtonItems
                               itemKeyPath:(NSString *)itemKeyPath
                          onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock;

@end
