//
//  DDCircleProgressView.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/22.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,DDCircleType) {
    DDCircleTypeNormal = 0,
    DDCircleTypeGradient,
};

@class DDCircleProgressView;
@protocol DDCircleProgressDelegate <NSObject>

@optional
- (void)circleProgressView:(DDCircleProgressView *)view progress:(CGFloat)progress;

@end

IB_DESIGNABLE
@interface DDCircleProgressView : UIView

@property (nonatomic,assign) DDCircleType type;
@property (nonatomic,assign) IBInspectable CGFloat progress;
@property (nonatomic,assign) IBInspectable CGFloat strokeRadius;
@property (nonatomic,assign) IBInspectable CGFloat strokeWidth;
@property (nonatomic,assign) IBInspectable CGFloat startAngle;
@property (nonatomic,assign) IBInspectable CGFloat endAngle;
@property (nonatomic,strong) IBInspectable UIColor * strokeColor;
@property (nonatomic,strong) IBInspectable UIColor * trackColor;
@property (nonatomic,strong) IBInspectable UIImage * gradientImage;
@property (nonatomic,weak) id<DDCircleProgressDelegate> progressDelegate;

@end
