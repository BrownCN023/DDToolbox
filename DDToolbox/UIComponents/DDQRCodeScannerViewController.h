//
//  DDQRCodeScannerViewController.h
//  DDMMediatorDemo
//
//  Created by TongAn001 on 2018/8/13.
//  Copyright © 2018年 Abram. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDAuthorizationTools.h"

@interface DDQRCodeScannerViewController : DDBaseViewController

@property (nonatomic,assign,readonly) CGRect cropRect;
@property (nonatomic,assign,readonly) BOOL allowHandleScanValueString;

- (void)startScan;
- (void)stopScan;
- (void)allowHandleScanValue;
- (void)disableHandleScanValue;
- (void)openFlash;
- (void)closeFlash;

- (void)qrCodeScannerErrorHandler:(NSError *)error;  //发生错误 调用
- (void)qrCodeScannerSuccessHandler:(NSString *)valueString; //扫描结果 调用，同时allowHandleScanValueString将置为NO
- (void)qrCodeScannerBrightnessValueHandler:(CGFloat)brightnessValue; //亮度值处理

@end
