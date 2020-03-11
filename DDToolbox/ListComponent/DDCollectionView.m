//
//  DDCollectionView.m
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDCollectionView.h"

@interface DDCollectionView()
@property (nonatomic,strong) DDCollectionViewProxy * viewProxy;
@end

@implementation DDCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        self.setupViewProxyBlock([DDCollectionViewProxy new]);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        self.setupViewProxyBlock([DDCollectionViewProxy new]);
    }
    return self;
}

- (DDCollectionSetupViewProxyBlock)setupViewProxyBlock{
    return ^(DDCollectionViewProxy * viewProxy){
        self.viewProxy = viewProxy;
        self.dataSource = viewProxy;
        self.delegate = viewProxy;
        return self;
    };
}

+ (DDCollectionView *)createCollectionView:(void (^)(DDCollectionView * _Nonnull collectionView))configBlock{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    DDCollectionView * v = [[DDCollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) collectionViewLayout:flowLayout];
    v.backgroundColor = UIColor.whiteColor;
    v.alwaysBounceVertical = YES;
    [v registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    if(configBlock){
        configBlock(v);
    }
    return v;
}

@end
