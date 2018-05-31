//
//  UIImageView+DDHelper.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/20.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "UIImageView+DDHelper.h"
#import "UIImage+DDHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloader.h>

@implementation UIImageView (DDHelper)


- (void)dd_roundRectImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder radius:(CGFloat)radius resize:(CGSize)resize{
    dispatch_main_async_safe(^{
        if(placeholder){
            self.image = [placeholder imageWithCornerRadius:radius size:placeholder.size];
        }else{
            self.image = nil;
        }
    });
    NSString *cacheurlStr = [url stringByAppendingFormat:@"rcache_w%@_h%@_r%@",@(resize.width),@(resize.height),@(radius)];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
    if (cacheImage) {
        dispatch_main_async_safe(^{
            self.image = cacheImage;
        });
    }else {
        [[SDWebImageManager.sharedManager imageDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if(finished){
                dispatch_main_async_safe(^{
                    UIImage * _rImage = [image imageWithCornerRadius:radius size:resize];
                    self.image = _rImage;
                    [[SDImageCache sharedImageCache] storeImage:_rImage forKey:cacheurlStr completion:nil];
                });
            }
        }];
    }
}

@end
