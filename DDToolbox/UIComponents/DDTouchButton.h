//
//  DDTouchButton.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTouchButton;
@protocol DDTouchButtonDelegate <NSObject>
@optional
- (void)touchButtonBegin:(DDTouchButton *)button;
- (void)touchButtonMoved:(DDTouchButton *)button isInside:(BOOL)isInside;
- (void)touchButtonEnded:(DDTouchButton *)button isInside:(BOOL)isInside;
- (void)touchButtonCancelled:(DDTouchButton *)button;
@end

@interface DDTouchButton : UIButton

@property (nonatomic,strong) IBInspectable UIColor * highlightBackgroundColor;
@property (nonatomic,weak) id<DDTouchButtonDelegate> delegate;

- (void)touchButtonBegin:(DDTouchButton *)button;
- (void)touchButtonMoved:(DDTouchButton *)button isInside:(BOOL)isInside;
- (void)touchButtonEnded:(DDTouchButton *)button isInside:(BOOL)isInside;
- (void)touchButtonCancelled:(DDTouchButton *)button;

@end
