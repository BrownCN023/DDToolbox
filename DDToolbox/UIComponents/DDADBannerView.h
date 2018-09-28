//
//  DDADBannerView.h
//  iOSDDMao
//
//  Created by TongAn001 on 2018/7/5.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseView.h"
#import "DDAutoLoopCollectionView.h"
#import "DDBaseCollectionViewCell.h"
#import "DDXib.h"

@interface DDADBannerCell : DDBaseCollectionViewCell

@property (nonatomic,strong) UILabel * titleLabel1;

@end

@interface DDADBannerView : DDBaseView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIButton * adImgView;
@property (nonatomic,strong) UIView * vLineView;
@property (nonatomic,strong) DDAutoLoopCollectionView * adItemLoopView;

@end
