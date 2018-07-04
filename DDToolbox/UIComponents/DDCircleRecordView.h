//
//  DDVideoRecordView.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTouchProgressView.h"

@class DDCircleRecordView;
@protocol DDCircleRecordViewDelegate <NSObject>

@optional
- (void)circleRecordViewBegin:(DDCircleRecordView *)view;
- (void)circleRecordViewTouchMoved:(DDCircleRecordView *)view isInside:(BOOL)isInside;
- (void)circleRecordViewEnd:(DDCircleRecordView *)view isInside:(BOOL)isInside;
- (void)circleRecordViewFinished:(DDCircleRecordView *)view duration:(CGFloat)duration isInside:(BOOL)isInside;

@end


@interface DDCircleRecordView : UIView

@property (nonatomic,strong) DDTouchProgressView * progressView;
@property (nonatomic,strong) UIView * fillView;
@property (nonatomic,weak) id<DDCircleRecordViewDelegate> delegate;
@property (nonatomic,assign) CGFloat minDuratin;
@property (nonatomic,assign) CGFloat maxDuratin;

@end
