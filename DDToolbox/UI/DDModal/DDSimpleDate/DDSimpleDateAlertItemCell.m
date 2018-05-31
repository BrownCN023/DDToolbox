//
//  DDSimpleDateAlertItemCell.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleDateAlertItemCell.h"
#import "DDMacro.h"

@implementation DDSimpleDateAlertItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.contentView.backgroundColor = DD_COLOR_Random();
}

- (void)configWithDataModel:(DDSimpleDateItem *)dataModel indexPath:(NSIndexPath *)indexPath{
    self.titleLabel.text = dataModel.day>0?@(dataModel.day).stringValue:nil;
    if(dataModel.isToday){
        self.todayImgView.hidden = NO;
    }else{
        self.todayImgView.hidden = YES;
    }
    if(dataModel.isSelected){
        self.titleLabel.textColor = [UIColor whiteColor];
        self.statusImgView.hidden = NO;
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
        self.statusImgView.hidden = YES;
    }
}

@end
