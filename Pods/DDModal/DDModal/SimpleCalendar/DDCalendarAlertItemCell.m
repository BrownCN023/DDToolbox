//
//  DDCalendarAlertItemCell.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDCalendarAlertItemCell.h"
#import <Masonry/Masonry.h>

@implementation DDCalendarAlertItemCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configWithDataModel:(DDDateItem *)dataModel indexPath:(NSIndexPath *)indexPath{
    self.titleLabel.text = dataModel.day>0?@(dataModel.day).stringValue:nil;
    if(dataModel.isToday){
        self.todayImgView.hidden = NO;
    }else{
        self.todayImgView.hidden = YES;
    }
    if(dataModel.isDisable){
        self.titleLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.statusButton.hidden = YES;
    }else{
        if(dataModel.isSelected){
            self.titleLabel.textColor = [UIColor whiteColor];
            self.statusButton.hidden = NO;
        }else{
            self.titleLabel.textColor = [UIColor blackColor];
            self.statusButton.hidden = YES;
        }
    }
}

#pragma mark - Setup
- (void)setupSubviews{
    [self.contentView addSubview:self.statusButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.todayImgView];
}
- (void)setupLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(self.contentView);
    }];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
    [self.todayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont systemFontOfSize:14];
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UIButton *)statusButton{
    if(!_statusButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setImage:[UIImage imageNamed:@"DDModal.bundle/dddate-selected.png"] forState:UIControlStateNormal];
        v.userInteractionEnabled = NO;
        v.tintColor = DDModal_COLOR_Hex(modalThemeColor4);
        _statusButton = v;
    }
    return _statusButton;
}

- (UIImageView *)todayImgView{
    if(!_todayImgView){
        UIImageView * v = [[UIImageView alloc] init];
        v.image = [UIImage imageNamed:@"DDModal.bundle/dddate-today.png"];
        _todayImgView = v;
    }
    return _todayImgView;
}

@end
