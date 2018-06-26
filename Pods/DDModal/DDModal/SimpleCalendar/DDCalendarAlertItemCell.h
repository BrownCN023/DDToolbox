//
//  DDCalendarAlertItemCell.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCalendarManager.h"
#import "DDModalThemeConfig.h"

@interface DDCalendarAlertItemCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *statusButton;
@property (strong, nonatomic) UIImageView *todayImgView;

- (void)configWithDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath;

@end
