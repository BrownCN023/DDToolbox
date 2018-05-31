//
//  DDXib.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/4.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDXib.h"

@implementation UIView (DDXib)
+ (instancetype)instanceFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end

@implementation UIViewController (DDXib)
+ (instancetype)instanceFromXib{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
@end

@implementation UITableView (Xib)
- (void)regCellNibWithClazz:(Class)clazz{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil] forCellReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regCellClassWithClazz:(Class)clazz{
    [self registerClass:clazz forCellReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regHeaderFooterNibWithClazz:(Class)clazz{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regHeaderFooterClassWithClazz:(Class)clazz{
    [self registerClass:clazz forHeaderFooterViewReuseIdentifier:NSStringFromClass(clazz)];
}
@end

@implementation UICollectionView (DDXib)
- (void)regCellNibWithClazz:(Class)clazz{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regCellClassWithClazz:(Class)clazz{
    [self registerClass:clazz forCellWithReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regSectionHeaderNibWithClazz:(Class)clazz{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regSectionHeaderClassWithClazz:(Class)clazz{
    [self registerClass:clazz forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regSectionFooterNibWithClazz:(Class)clazz{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(clazz)];
}
- (void)regSectionFooterClassWithClazz:(Class)clazz{
    [self registerClass:clazz forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(clazz)];
}

@end

@implementation DDXib

@end
