//
//  DDVideoRecordViewController.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/7/10.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDCircleRecordView.h"
#import "DDRecordVideoPreviewView.h"
#import <Masonry/Masonry.h>
#import "DDMacro.h"
#import <AVFoundation/AVFoundation.h>

@interface DDVideoRecordViewController : DDBaseViewController

@property (nonatomic,copy) void (^onRecordCompletionBlock)(NSString * videoPath);

@end


@interface DDVideoRecordViewController (Expand)

+ (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                              outputURL:(NSURL*)outputURL
                        completeHandler:(void (^)(void))handler;

+ (UIImage *)getVideoFirstFramePreViewImage:(NSString *)videoPath duration:(float *)duration;

@end

