//
//  UIImageView+SDWebImageFadeAnimation.h
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SDWebImageFadeAnimation)

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
