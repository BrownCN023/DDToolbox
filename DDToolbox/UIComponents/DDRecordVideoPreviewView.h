//
//  JTSmallVideoView.h
//  JTSocial
//
//  Created by Brown on 2017/10/26.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

//小视频录制组件
@interface DDRecordVideoPreviewView : UIView

@property (nonatomic, copy,readonly) NSString * videoPath;//文件路径
//录制并保存完成回调
@property (nonatomic,copy) void (^onRecordFinishedBlock)(NSString * videoPath);

//开始预览
- (void)startPreview;
//切换摄像头
- (void)changeCamera;
//开始录制
- (void)startRecordVideo;
//停止录制
- (void)stopVideoRecording;


@end
