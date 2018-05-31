//
//  DDXib.h
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <UIKit/UIKit.h>

@interface UIView (DDXib)
+ (instancetype)instanceFromXib;
@end

@interface UIViewController (DDXib)
+ (instancetype)instanceFromXib;
@end

@interface UITableView (Xib)
- (void)regCellNibWithClazz:(Class)clazz;
- (void)regCellClassWithClazz:(Class)clazz;
- (void)regHeaderFooterNibWithClazz:(Class)clazz;
- (void)regHeaderFooterClassWithClazz:(Class)clazz;
@end

@interface UICollectionView (DDXib)
- (void)regCellNibWithClazz:(Class)clazz;
- (void)regCellClassWithClazz:(Class)clazz;
- (void)regSectionHeaderNibWithClazz:(Class)clazz;
- (void)regSectionHeaderClassWithClazz:(Class)clazz;
- (void)regSectionFooterNibWithClazz:(Class)clazz;
- (void)regSectionFooterClassWithClazz:(Class)clazz;
@end


@interface DDXib : NSObject

@end
