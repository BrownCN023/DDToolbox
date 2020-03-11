//
//  UIView+DDBorder.m
//  DDTooboxDemo
//
//  Created by brown on 2018/5/29.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "UIView+DDBorder.h"
#import <Masonry/Masonry.h>

@implementation UIView (DDBorder)

- (void)simpleBorder:(DDBorderType)type width:(CGFloat)width color:(UIColor *)color{
    UIView * lineView = [self lineViewByType:type];
    if(lineView){
        lineView.backgroundColor = color;
        [self bringSubviewToFront:lineView];
    }else{
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
    }
    switch (type) {
        case DDBorderTypeTop:{
            [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.mas_equalTo(0);
                make.height.mas_equalTo(width);
            }];
        }
            break;
        case DDBorderTypeLeft:{
            [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(width);
            }];
        }
            break;
        case DDBorderTypeBottom:{
            [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(0);
                make.height.mas_equalTo(width);
            }];
        }
            break;
        case DDBorderTypeRight:{
            [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.right.mas_equalTo(0);
                make.width.mas_equalTo(width);
            }];
        }
            break;
        default:
            break;
        }
}

- (UIView *)lineViewByType:(DDBorderType)type{
    return [self viewWithTag:(99990+type)];
}

@end
