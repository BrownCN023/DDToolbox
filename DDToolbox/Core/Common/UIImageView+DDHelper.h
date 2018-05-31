//
//  UIImageView+DDHelper.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DDHelper)

- (void)dd_roundRectImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder radius:(CGFloat)radius resize:(CGSize)resize;

@end
