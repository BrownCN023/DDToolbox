//
//  DDTouchProgressView.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDTouchView.h"

@class DDTouchProgressView;
@protocol DDTouchProgressViewDelegate <NSObject>
@optional
- (void)touchProgressViewBegin:(DDTouchProgressView *)view;
- (void)touchProgressViewMoved:(DDTouchProgressView *)view isInside:(BOOL)isInside;
- (void)touchProgressViewEnded:(DDTouchProgressView *)view isInside:(BOOL)isInside;
- (void)touchProgressViewCancelled:(DDTouchProgressView *)view;
- (void)touchProgressView:(DDTouchProgressView *)view duration:(CGFloat)duration isInside:(BOOL)isInside;
@end

@interface DDTouchProgressView : DDTouchView

@property (nonatomic,assign) CGFloat strokeRadius;
@property (nonatomic,assign) CGFloat strokeWidth;
@property (nonatomic,assign) NSString * strokeCap; //kCALineCapButt kCALineCapRound kCALineCapSquare
@property (nonatomic,strong) UIColor * strokeColor;
@property (nonatomic,strong) UIColor * fillColor;
@property (nonatomic,strong) UIColor * trackColor;
@property (nonatomic,assign) CGFloat maxDuration;
@property (nonatomic,weak) id<DDTouchProgressViewDelegate> progressDelegate;

- (void)clearAnimation;

@end
