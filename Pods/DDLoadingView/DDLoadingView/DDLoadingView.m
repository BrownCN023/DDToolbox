//
//  DDLoadingView.m
//  DDLoadingViewDemo
//
//  Created by TongAn001 on 2018/6/13.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDLoadingView.h"

@implementation DDLoadingView

- (void)dealloc{
    NSLog(@"--- dealloc %@ ---",self.class);
}

- (void)beginLoading{
    if(_loadingStatus != DDLoadingStatusLoading){
        _loadingStatus = DDLoadingStatusLoading;
        if(self.onClickLoadingBlock){
            self.onClickLoadingBlock();
        }
    }
}
- (void)endLoading{
    _loadingStatus = DDLoadingStatusIlde;
}
- (void)loadFailed{
    _loadingStatus = DDLoadingStatusFailed;
}
- (void)loadError:(NSString *)msg{
    _loadingStatus = DDLoadingStatusError;
}
- (void)loadNoData{
    _loadingStatus = DDLoadingStatusNoData;
}

- (void)setConfigModel:(DDLoadingViewConfig *)configModel{
    _configModel = configModel;
    if(configModel.backgroundColor){
        self.backgroundColor = configModel.backgroundColor;
    }
}

@end
