//
//  DDTableViewCell.m
//  DDMobDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(id)cellData
          indexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    self.cellData = cellData;
}

- (void)setCellData:(id)cellData{
    [self removeObserversFromCellData];
    if(_cellData != cellData){
        _cellData = cellData;
        [self refreshSubviewsData];
        [self layoutIfNeeded];
    }
    [self addObserversToCellData];
}

- (void)refreshSubviewsData{
    
}

//KVO
- (NSArray<NSString *> *)keyPathOfObserverInCellData{
    return nil;
}

- (void)addObserversToCellData{
    NSArray<NSString *> * keys = [self keyPathOfObserverInCellData];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cellData addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
    }];
}

- (void)removeObserversFromCellData{
    NSArray<NSString *> * keys = [self keyPathOfObserverInCellData];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cellData removeObserver:self forKeyPath:key context:nil];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self refreshSubviewsData];
    [self layoutIfNeeded];
}

- (void)dealloc{
    [self removeObserversFromCellData];
}

@end
