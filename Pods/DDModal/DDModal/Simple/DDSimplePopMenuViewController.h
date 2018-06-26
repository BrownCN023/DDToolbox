//
//  DDSimplePopViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDModalAlertViewController.h"

typedef NS_ENUM(NSInteger, DDSimplePopPosition) {
    DDSimplePopPositionLeftTop = 0,
    DDSimplePopPositionRightTop,
    DDSimplePopPositionLeftBottom,
    DDSimplePopPositionRightBottom
};

@interface DDSimplePopMenuViewController : DDModalAlertViewController

+ (id)showPop:(NSArray *)items titleKeyPath:(NSString *)titleKeyPath iconKeyPath:(NSString *)iconKeyPath position:(DDSimplePopPosition)position onClickItemBlock:(void (^)(NSInteger itemIndex,id itemObj))clickItemBlock;

- (CGFloat)popViewWidth;
- (CGFloat)popViewOffsetX;
- (CGFloat)popViewOffsetY;
@end
