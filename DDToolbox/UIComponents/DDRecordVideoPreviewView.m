//
//  JTSmallVideoView.m
//  JTSocial
//
//  Created by Brown on 2017/10/26.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import "DDRecordVideoPreviewView.h"
#import <AVFoundation/AVFoundation.h>
#import "DDMacro.h"
@interface DDRecordVideoPreviewView()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层

@property (nonatomic, strong) UIView *containerView;//录制视频容器
@property (nonatomic, copy) NSString * videoPath;//文件路径

@end

@implementation DDRecordVideoPreviewView

- (void)dealloc{
    DDPLog(@"dealloc %@",[self class]);
    [self stopVideoRecording];
    [self.captureSession stopRunning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupComponent];
        [self setupLayout];
        [self setupPreview];
        [self addGenstureRecognizer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupComponent];
        [self setupLayout];
        [self setupPreview];
        [self addGenstureRecognizer];
    }
    return self;
}

- (void)setupComponent{
    [self addSubview:self.containerView];
}

- (void)setupLayout{
    self.containerView.frame = [UIScreen mainScreen].bounds;
}

- (void)setupPreview{
    //初始化会话
    self.captureSession = [[AVCaptureSession alloc] init];
    //设置分辨率
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    //获得输入设备（前置摄像头）
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    if (!captureDevice) {
        DDPLog(@"取得前置置摄像头时出现问题");
        return;
    }
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    NSError *error = nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        DDPLog(@"取得设备输入对象时出错，错误原因：%@", error.localizedDescription);
        return;
    }
    AVCaptureDeviceInput *audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        DDPLog(@"取得设备输入对象时出错，错误原因：%@", error.localizedDescription);
        return;
    }
    
    //初始化设备输出对象，用于获得输出数据
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    //不设置这个属性，超过10s的视频会没有声音
    _captureMovieFileOutput.movieFragmentInterval = kCMTimeInvalid;
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection = [_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported]) {
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    
    //摄像头方向
    AVCaptureConnection *captureConnection = [self.captureVideoPreviewLayer connection];
    captureConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    CALayer *layer = _containerView.layer;
    layer.masksToBounds = YES;
    
    _captureVideoPreviewLayer.frame = layer.bounds;
    //填充模式
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //将视频预览层添加到界面中
    //[layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
    [layer addSublayer:_captureVideoPreviewLayer];
    
    [self addNotificationToCaptureDevice:captureDevice];
}

#pragma mark - Noti


#pragma mark - Method
- (void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

//给输入设备添加通知
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice
{
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //捕获区域发生改变
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

//改变设备属性的统一操作方法
- (void)changeDeviceProperty:(void (^)(AVCaptureDevice *))propertyChange
{
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else {
        NSLog(@"设置设备属性过程发生错误，错误信息：%@", error.localizedDescription);
    }
}

//捕获区域改变
- (void)areaChange:(NSNotification *)notification
{
    //DDPLog(@"捕获区域改变");
}

- (void)changeCamera{
    AVCaptureDevice *currentDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [currentDevice position];
    [self removeNotificationFromCaptureDevice:currentDevice];
    
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition = AVCaptureDevicePositionFront;
    if (currentPosition == AVCaptureDevicePositionUnspecified || currentPosition == AVCaptureDevicePositionFront) {
        toChangePosition = AVCaptureDevicePositionBack;
    }
    toChangeDevice = [self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
}

//取得指定位置的摄像头
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

//视频路径
- (NSString *)getOutPutPathPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd-hh-mm-ss-sss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString * libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString * recordPath = [libDir stringByAppendingPathComponent:@"Record/SmallVideo"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:recordPath]){
        NSError * error = nil;
        [fm createDirectoryAtPath:recordPath withIntermediateDirectories:YES attributes:nil error:&error];
        DDPLog(@"创建录制小视频路径结果:%@",recordPath);
    }else{
        DDPLog(@"录制小视频路径已创建:%@",recordPath);
    }

    NSString * path = [recordPath stringByAppendingPathComponent:[NSString stringWithFormat:@"iOS-%@.mov",dateStr]];
    return path;
}

//添加点按手势，点按时聚焦
- (void)addGenstureRecognizer
{
    [self.containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)]];
}

- (void)tapScreen:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point = [tapGesture locationInView:self.containerView];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

//设置聚焦点
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

#pragma mark - Method Public

- (void)startPreview{
    [self.captureSession startRunning];
}

//停止视频录制
- (void)stopVideoRecording{
    DDPLog(@"停止录制");
    if([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];
    }
}

- (void)startRecordVideo{
    DDPLog(@"开始录制");
    [self stopVideoRecording];
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //预览图层和视频方向保持一致
    captureConnection.videoOrientation = [self.captureVideoPreviewLayer connection].videoOrientation;
    self.videoPath = [self getOutPutPathPath];
    DDPLog(@"getOutPutPathPath:%@",self.videoPath);
    [self.captureMovieFileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:self.videoPath] recordingDelegate:self];
}

#pragma mark - Delegate
#pragma mark - 视频输出代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    DDPLog(@"开始录制...");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    DDPLog(@"视频录制完成.");
    if(self.onRecordFinishedBlock){
        self.onRecordFinishedBlock(self.videoPath);
    }
}

#pragma mark - Getter/Setter
- (UIView *)containerView{
    if(!_containerView){
        UIView * v = [[UIView alloc] initWithFrame:CGRectZero];
        v.backgroundColor = [UIColor grayColor];
        _containerView = v;
    }
    return _containerView;
}

@end
