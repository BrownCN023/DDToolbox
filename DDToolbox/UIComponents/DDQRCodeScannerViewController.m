//
//  DDQRCodeScannerViewController.m
//  DDMMediatorDemo
//
//  Created by TongAn001 on 2018/8/13.
//  Copyright © 2018年 Abram. All rights reserved.
//

#import "DDQRCodeScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

#define FourBorderLength 10
#define FourBorderWidth 2
#define GridSize 6

@interface DDQRCodeScanCropView : UIView

@property (nonatomic,assign) CGRect cropRect;

@end

@implementation DDQRCodeScanCropView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        CGFloat mainRectWidth = frame.size.width;
        CGFloat mainRectHeight = frame.size.height;
        
        CGFloat cropX = mainRectWidth/GridSize;
        CGFloat cropWidth = mainRectWidth - cropX*2;
        CGFloat cropHeight = cropWidth;
        CGFloat cropY = (mainRectHeight-cropHeight)/2*0.7;
        self.cropRect = CGRectMake(cropX, cropY, cropWidth, cropHeight);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self addClearRect:rect];
    [self addFourBorder:rect];
}

//中间透明
- (void)addClearRect:(CGRect)mainRect {
    
    CGFloat cropX = self.cropRect.origin.x;
    CGFloat cropWidth = self.cropRect.size.width;
    CGFloat cropHeight = self.cropRect.size.height;
    CGFloat cropY = self.cropRect.origin.y;
    
    [[UIColor colorWithWhite:0 alpha:0.2] setFill];
    UIRectFill(mainRect);
    CGRect clearRect = CGRectMake(cropX, cropY, cropWidth, cropHeight);
    CGRect clearIntersection = CGRectIntersection(clearRect, mainRect);
    [[UIColor clearColor] setFill];
    UIRectFill(clearIntersection);
}

//四个角
- (void)addFourBorder:(CGRect)mainRect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, FourBorderWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    
    CGFloat cropX = self.cropRect.origin.x;
    //CGFloat cropWidth = self.cropRect.size.width;
    CGFloat cropHeight = self.cropRect.size.height;
    CGFloat cropY = self.cropRect.origin.y;
    NSInteger gridOffset = GridSize-1;
    
    CGPoint upLeftPoints[] = {CGPointMake(cropX, cropY), CGPointMake(cropX + FourBorderLength, cropY), CGPointMake(cropX, cropY), CGPointMake(cropX, cropY + FourBorderLength)};
    CGPoint upRightPoints[] = {CGPointMake(gridOffset*cropX - FourBorderLength, cropY), CGPointMake(gridOffset*cropX, cropY), CGPointMake(gridOffset*cropX, cropY), CGPointMake(gridOffset*cropX, cropY + FourBorderLength)};
    
    CGPoint belowLeftPoints[] = {CGPointMake(cropX, cropY+cropHeight), CGPointMake(cropX, cropY+cropHeight - FourBorderLength), CGPointMake(cropX, cropY+cropHeight), CGPointMake(cropX +FourBorderLength, cropY+cropHeight)};
    CGPoint belowRightPoints[] = {CGPointMake(gridOffset*cropX, cropY+cropHeight), CGPointMake(gridOffset*cropX - FourBorderLength, cropY+cropHeight), CGPointMake(gridOffset*cropX, cropY+cropHeight), CGPointMake(gridOffset*cropX, cropY+cropHeight - FourBorderLength)};
    
    CGContextStrokeLineSegments(ctx, upLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, upRightPoints, 4);
    CGContextStrokeLineSegments(ctx, belowLeftPoints, 4);
    CGContextStrokeLineSegments(ctx, belowRightPoints, 4);
}

@end

@interface DDQRCodeScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession * captureSession;
@property (nonatomic, strong) DDQRCodeScanCropView * scanCropView;
@property (nonatomic, assign) BOOL allowHandleScanValueString;

@end

@implementation DDQRCodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startScan];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self allowHandleScanValue];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self disableHandleScanValue];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopScan];
}

- (void)startScan{
    if(self.captureSession){
        [self.captureSession startRunning];
    }
}

- (void)stopScan{
    if(self.captureSession){
        [self.captureSession stopRunning];
    }
}

- (void)allowHandleScanValue{
    _allowHandleScanValueString = YES;
}

- (void)disableHandleScanValue{
    _allowHandleScanValueString = NO;
}

- (void)openFlash{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice unlockForConfiguration];
        }
    }
}

- (void)closeFlash{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupNoti{
    [super setupNoti];
}
- (void)setupNavigation{
    [super setupNavigation];
}
- (void)setupSubviews{
    [super setupSubviews];
    self.view.backgroundColor = [UIColor blackColor];
    
    [DDAuthorizationTools checkMediaStatus:AVMediaTypeVideo completionHandler:^(DDAuthorizationStatus status) {
        switch (status) {
            case DDAuthorizationNotDetermined:{
                [DDAuthorizationTools requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted){
                        [self createCapture];
                    }else{
                        NSDictionary * userInfo = @{ NSLocalizedDescriptionKey : @"相机不可用" };
                        NSError * error = [NSError errorWithDomain:NSLocalizedDescriptionKey code:-101 userInfo:userInfo];
                        [self qrCodeScannerErrorHandler:error];
                    }
                }];
            }
                break;
            case DDAuthorizationRestricted:
            case DDAuthorizationDenied:{
                NSDictionary * userInfo = @{ NSLocalizedDescriptionKey : @"相机不可用" };
                NSError * error = [NSError errorWithDomain:NSLocalizedDescriptionKey code:-101 userInfo:userInfo];
                [self qrCodeScannerErrorHandler:error];
            }
                break;
            case DDAuthorizationAuthorized:{
                [self createCapture];
            }
                break;
                
            default:
                break;
        }
    }];
}
- (void)setupLayout{
    [super setupLayout];
}

- (void)createCapture{
    NSError * error = nil;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        [self qrCodeScannerErrorHandler:error];
        return;
    }
    //创建输出
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    AVCaptureVideoDataOutput * videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    //添加输入输出
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    [self.captureSession addOutput:metadataOutput];
    [self.captureSession addOutput:videoDataOutput];
    
    //设置输出类型(二维码)
    [metadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    
    //设置图层填充方式
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //设置图层的frame
    [previewLayer setFrame:self.view.bounds];
    
    //将图层添加到预览view
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描范围
    CGRect mainRect = [UIScreen mainScreen].bounds;
    
    self.scanCropView = [[DDQRCodeScanCropView alloc] initWithFrame:self.view.bounds];
    
    CGRect rect = self.scanCropView.cropRect;
    
    metadataOutput.rectOfInterest = CGRectMake(rect.origin.y/mainRect.size.height, rect.origin.x/mainRect.size.width, rect.size.height/mainRect.size.height, rect.size.width/mainRect.size.width);
    
    [self.view addSubview:self.scanCropView];
    
    [self.captureSession startRunning];
}



- (void)qrCodeScannerErrorHandler:(NSError *)error{
    
}

- (void)qrCodeScannerSuccessHandler:(NSString *)valueString{
    
}

- (void)qrCodeScannerBrightnessValueHandler:(CGFloat)brightnessValue{
    
}

- (CGRect)cropRect{
    return self.scanCropView.cropRect;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if(_allowHandleScanValueString && metadataObjects.count > 0){
        [self disableHandleScanValue];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        [self qrCodeScannerSuccessHandler:metadataObject.stringValue];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    [self qrCodeScannerBrightnessValueHandler:brightnessValue];
}

@end
