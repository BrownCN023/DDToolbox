//
//  DDAdvertView.h
//  iOSTASmartApp
//
//  Created by TongAn001 on 2018/10/10.
//  Copyright © 2018 Abram. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAdvertConfig : NSObject

@property (nonatomic,copy) NSString * adImageUrl;
@property (nonatomic,copy) NSString * adOpenUrl;
@property (nonatomic,assign) CGRect skipFrame;
@property (nonatomic,assign) NSInteger duration;  //秒(s)

@property (nonatomic,copy) void (^onDestoryBlock)(void);
@property (nonatomic,copy) void (^onClickAdImageBlock)(NSString * adOpenUrl);

@end

@interface DDAdvertView : UIView

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIButton * skipButton;

- (id)initWithFrame:(CGRect)frame config:(DDAdvertConfig *)config;


@end

NS_ASSUME_NONNULL_END
