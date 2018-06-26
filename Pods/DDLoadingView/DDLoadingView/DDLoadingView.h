//
//  DDLoadingView.h
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDLoadingViewConfig.h"

typedef NS_ENUM(NSInteger,DDLoadingStatus) {
    DDLoadingStatusIlde = 0,
    DDLoadingStatusLoading,
    DDLoadingStatusFailed,
    DDLoadingStatusError,
    DDLoadingStatusNoData
};

@protocol DDLoadingProtocol <NSObject>

@required
- (void)beginLoading;
- (void)endLoading;
- (void)loadFailed;
- (void)loadError:(NSString *)msg;
- (void)loadNoData;

@end

@interface DDLoadingView : UIView<DDLoadingProtocol>

@property (nonatomic,copy) void (^onClickLoadingBlock)(void);
@property (nonatomic,assign,readonly) DDLoadingStatus loadingStatus;
@property (nonatomic,strong) DDLoadingViewConfig * configModel;

@end
