//
//  DDSimpleDateAlertHeaderView.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/30.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleDateAlertHeaderView.h"
#import "UIView+DDHelper.h"

@implementation DDSimpleDateAlertHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel layerCorners:UIRectCornerAllCorners cornerSize:CGSizeMake(2, 2)];
}

- (void)configDataModel:(DDSimpleDateSection *)dataModel section:(NSInteger)section{
    [super configDataModel:dataModel section:section];
    self.titleLabel.text = [NSString stringWithFormat:@"%04ld年%02ld月",(long)dataModel.year,(long)dataModel.month];
}

@end
