//
//  DDCollectionViewPresenter.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/9/28.
//  Copyright © 2018 abiang. All rights reserved.
//

#import "DDCollectionViewPresenter.h"

@implementation DDCollectionViewPresenter

- (id)initWithCollectionView:(UICollectionView *)collectionView{
    if(self = [super init]){
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // Configure the cell
    //return cell;
    return [[UICollectionViewCell alloc] init];
}

@end
