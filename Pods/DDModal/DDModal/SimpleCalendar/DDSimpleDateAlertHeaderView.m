//
//  DDSimpleDateAlertHeaderView.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/5/30.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleDateAlertHeaderView.h"


@implementation DDSimpleDateAlertHeaderView

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

- (void)configDataModel:(DDDateSection *)dataModel section:(NSInteger)section{
    self.titleLabel.text = [NSString stringWithFormat:@"%04ld年%02ld月",(long)dataModel.year,(long)dataModel.month];
}

#pragma mark - Setup
- (void)setupSubviews{
    
    [self modalSimpleBorder:DDModalBorderTypeTop width:0.5 color:DDModal_COLOR_Hex(0xE6E6E6)];
    [self addSubview:self.titleLabel];
    [self.titleLabel modalLayerCorners:UIRectCornerAllCorners cornerRect:CGRectMake(0, 0, 100, 20) cornerSize:CGSizeMake(2, 2)];
}
- (void)setupLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.bottom.mas_equalTo(0);
        make.centerX.equalTo(self);
    }];
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * v = [[UILabel alloc] init];
        v.backgroundColor = DDModal_COLOR_Hex(0xF1F1F1);
        v.textAlignment = NSTextAlignmentCenter;
        v.font = [UIFont systemFontOfSize:14];
        _titleLabel = v;
    }
    return _titleLabel;
}

@end
