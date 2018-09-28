//
//  DDVideoRecordViewController.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/7/10.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDVideoRecordViewController.h"



typedef NS_ENUM(NSInteger,DDVideoRecordState) {
    DDVideoRecordStateNone = 0,
    DDVideoRecordStateRecording = 1,
    DDVideoRecordStateStop = 2,
    DDVideoRecordStateFinished = 3,
    DDVideoRecordStateCancel = 4
};

@interface DDVideoRecordViewController ()<DDCircleRecordViewDelegate>

@property (nonatomic,strong) DDRecordVideoPreviewView * videoPreview;
@property (nonatomic,strong) DDCircleRecordView * recordButtonView;
@property (nonatomic,strong) UILabel * recordTipLabel;
@property (nonatomic,strong) UIButton * closeButton;
@property (nonatomic,strong) UIButton * switchCameraButton;

@property (nonatomic,assign) DDVideoRecordState recordState;
@property (nonatomic,assign) float recordTime;  //录制时长

@end

@implementation DDVideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.videoPreview startPreview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.view addSubview:self.videoPreview];
    [self.view addSubview:self.recordTipLabel];
    [self.view addSubview:self.recordButtonView];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.switchCameraButton];
    
    DDWeakSelf(self);
    self.videoPreview.onRecordFinishedBlock = ^(NSString *videoPath) {
        if(weakself.recordState == DDVideoRecordStateFinished){
            if(weakself.recordTime > weakself.recordButtonView.minDuratin){
                [weakself dismissViewControllerAnimated:YES completion:^{
                    if(weakself.onRecordCompletionBlock){
                        weakself.onRecordCompletionBlock(videoPath);
                    }
                }];
            }else{
                [weakself handleDeleteVideoWithVideoPath:videoPath];
            }
        }else{
            if(weakself.recordState != DDVideoRecordStateRecording){
                [weakself handleDeleteVideoWithVideoPath:videoPath];
            }
        }
    };
}
- (void)setupLayout{
    [super setupLayout];
    [self.videoPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    [self.recordTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.recordButtonView.mas_top).offset(-80);
    }];
    [self.recordButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-50);
        make.size.mas_equalTo(CGSizeMake(70, 44));
    }];
    [self.switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(-50);
        make.size.mas_equalTo(CGSizeMake(70, 44));
    }];
}

- (void)clickCloseButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSwitchButton{
    void (^asyncThreadBlock)(void) = ^{
        [self.videoPreview changeCamera];
    };
    DD_GCD_Global_Async(asyncThreadBlock);
}

- (void)handleTouchDown{
    [UIView animateWithDuration:0.25 animations:^{
        self.recordTipLabel.alpha = 1;
    }];
    self.recordTipLabel.text = @"上滑取消录制";
}

- (void)handleTouchDragExit{
    self.recordTipLabel.text = @"放开取消录制";
}

- (void)handleClear{
    [UIView animateWithDuration:0.25 animations:^{
        self.recordTipLabel.alpha = 0;
    }];
    self.recordTipLabel.text = @"上滑取消录制";
}

- (void)handleDeleteVideoWithVideoPath:(NSString *)videoPath{
    void (^asyncThreadBlock)(void) = ^{
        NSFileManager* fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:videoPath]){
            NSError * error = nil;
            [fm removeItemAtPath:videoPath error:&error];
            if(!error){
                DDPLog(@"移除文件成功:%@",videoPath);
            }else{
                DDPLog(@"移除文件失败:%@",videoPath);
            }
        }
    };
    DD_GCD_Global_Async(asyncThreadBlock);
}

- (void)circleRecordViewBegin:(DDCircleRecordView *)view{
    self.recordTime = 0.0f;
    self.recordState = DDVideoRecordStateRecording;
    [self.videoPreview startRecordVideo];
    [self handleTouchDown];
}
- (void)circleRecordViewTouchMoved:(DDCircleRecordView *)view isInside:(BOOL)isInside{
    if(isInside){
        [self handleTouchDown];
    }else{
        [self handleTouchDragExit];
    }
}
- (void)circleRecordViewEnd:(DDCircleRecordView *)view isInside:(BOOL)isInside{
    
}
- (void)circleRecordViewFinished:(DDCircleRecordView *)view duration:(CGFloat)duration isInside:(BOOL)isInside{
    [self handleClear];
    self.recordTime = duration;
    if(isInside){
        self.recordState = DDVideoRecordStateFinished;
        [self.videoPreview stopVideoRecording];
    }else{
        self.recordState = DDVideoRecordStateCancel;
        [self.videoPreview stopVideoRecording];
        [self handleDeleteVideoWithVideoPath:self.videoPreview.videoPath];
    }
}


- (UILabel *)recordTipLabel{
    if(!_recordTipLabel){
        UILabel * v = [[UILabel alloc] initWithFrame:CGRectZero];
        v.text = @"上滑取消录制";
        v.alpha = 0;
        v.textColor = [UIColor whiteColor];
        v.textAlignment = NSTextAlignmentCenter;
//        v.backgroundColor = [UIColor orangeColor];
        _recordTipLabel = v;
    }
    return _recordTipLabel;
}

- (DDCircleRecordView *)recordButtonView{
    if(!_recordButtonView){
        DDCircleRecordView * v = [[DDCircleRecordView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
//        v.center = CGPointMake(DD_ScreenWidth/2, DD_ScreenHeight-60-75.0/2);
        v.layer.cornerRadius = 75/2.0f;
        v.backgroundColor = [UIColor whiteColor];
        v.maxDuratin = 30.0f;
        v.minDuratin = 3;
        v.delegate = self;
        v.fillView.backgroundColor = DD_COLOR_Hex(0x50BE78);
        v.progressView.strokeColor = DD_COLOR_Hex(0x50BE78);
        _recordButtonView = v;
    }
    return _recordButtonView;
}

- (DDRecordVideoPreviewView *)videoPreview{
    if(!_videoPreview){
        DDRecordVideoPreviewView * v = [[DDRecordVideoPreviewView alloc] initWithFrame:self.view.bounds];
        v.backgroundColor = [UIColor blackColor];
        _videoPreview = v;
    }
    return _videoPreview;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-arrow.png"] forState:UIControlStateNormal];
//        v.backgroundColor = DD_COLOR_Random();
        [v addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = v;
    }
    return _closeButton;
}

- (UIButton *)switchCameraButton{
    if(!_switchCameraButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.frame = CGRectMake(0, 0, 100, 40);
        [v setImage:[UIImage imageNamed:@"DDToolbox.bundle/ddtoolbox-camera.png"] forState:UIControlStateNormal];
//        v.backgroundColor = DD_COLOR_Random();
        [v addTarget:self action:@selector(clickSwitchButton) forControlEvents:UIControlEventTouchUpInside];
        _switchCameraButton = v;
    }
    return _switchCameraButton;
}

@end



@implementation DDVideoRecordViewController (Expand)

+ (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                              outputURL:(NSURL*)outputURL
                        completeHandler:(void (^)(void))handler{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        DD_GCD_Main_AsyncSafe(handler);
    }];
}

+ (UIImage *)getVideoFirstFramePreViewImage:(NSString *)videoPath duration:(float *)duration{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    CMTime time = [asset duration];
    int totalSeconds = ceil(time.value/time.timescale);
    *duration = totalSeconds;
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}

@end
