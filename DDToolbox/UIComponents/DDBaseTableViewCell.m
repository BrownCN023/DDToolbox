//
//  DDBaseTableViewCell.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDBaseTableViewCell.h"

@implementation DDBaseTableViewCell

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self setupData];
        [self setupNoti];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupData{
    
}
- (void)setupNoti{
    
}
- (void)setupSubviews{

}
- (void)setupLayout{

}

- (void)bindingViewModel:(DDTableRowViewModel *)viewModel indexPath:(NSIndexPath *)indexPath{
    self.viewModel = viewModel;
    self.indexPath = indexPath;
    self.accessoryType = viewModel.accessoryType;
}

- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    self.dataModel = dataModel;
    self.indexPath = indexPath;
}

@end
