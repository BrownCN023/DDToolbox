//
//  UIImage+DDHelper.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/19.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DDHelper)

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;;

+ (UIImage *)firstFrameWithVideoPath:(NSString *)videoPath targetSize:(CGSize)targetSize;

- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

@end
