//
//  UIImageView+SDWebImageFadeAnimation.m
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import "UIImageView+SDWebImageFadeAnimation.h"


@implementation UIImageView (SDWebImageFadeAnimation)

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock
{
    __weak __typeof(self)wself = self;
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5f];
            [animation setType:kCATransitionFade];
            animation.removedOnCompletion = YES;
            [wself.layer addAnimation:animation forKey:@"transition"];
        }
        if (completedBlock) {
            completedBlock(image, error, cacheType, url);
        }
    }];
    [self.layer removeAnimationForKey:@"transition"];
}

@end
