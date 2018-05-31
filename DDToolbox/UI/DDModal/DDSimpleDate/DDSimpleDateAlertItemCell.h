//
//  DDSimpleDateAlertItemCell.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDBaseCollectionViewCell.h"
#import "DDSimpleDateCalendarManager.h"

@interface DDSimpleDateAlertItemCell : DDBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;
@property (weak, nonatomic) IBOutlet UIImageView *todayImgView;

@end
