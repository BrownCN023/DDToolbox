//
//  DDTouchView.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/7/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTouchView : UIView

@property (nonatomic,strong) IBInspectable UIColor * highlightBackgroundColor;

- (void)touchViewBegin:(DDTouchView *)view;
- (void)touchViewMoved:(DDTouchView *)view isInside:(BOOL)isInside;
- (void)touchViewEnded:(DDTouchView *)view isInside:(BOOL)isInside;
- (void)touchViewCancelled:(DDTouchView *)view;

@end
