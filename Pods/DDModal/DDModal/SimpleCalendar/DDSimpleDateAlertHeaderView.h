//
//  DDSimpleDateAlertHeaderView.h
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/30.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCalendarManager.h"
#import "UIView+DDModal.h"
#import <Masonry/Masonry.h>
#import "DDModalConfig.h"

@interface DDSimpleDateAlertHeaderView : UICollectionReusableView

@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,strong) id dataModel;
@property (nonatomic,assign) NSInteger section;

- (void)configDataModel:(id)dataModel section:(NSInteger)section;
@end
