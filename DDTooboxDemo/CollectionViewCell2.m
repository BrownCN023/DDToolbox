//
//  CollectionViewCell2.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "CollectionViewCell2.h"
#import "DDMacro.h"
@implementation CollectionViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = DD_COLOR_Random();
}

@end
