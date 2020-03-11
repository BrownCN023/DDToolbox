//
//  DDTableView.m
//  DDListComponentsDemo
//
//  Created by abiaoyo on 2020/2/28.
//  Copyright © 2020 abiaoyo. All rights reserved.
//

#import "DDTableView.h"

@interface DDTableView()
@property (nonatomic,strong) DDTableViewProxy * viewProxy;
@end

@implementation DDTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        self.setupViewProxyBlock([DDTableViewProxy new]);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style]){
        self.setupViewProxyBlock([DDTableViewProxy new]);
    }
    return self;
}

- (DDTableSetupViewProxyBlock)setupViewProxyBlock{
    return ^(DDTableViewProxy * viewProxy){
        self.viewProxy = viewProxy;
        self.dataSource = viewProxy;
        self.delegate = viewProxy;
        return self;
    };
}

+ (DDTableView *)createPlainTableView:(void (^)(DDTableView * _Nonnull tableView))configBlock
{
    DDTableView * v = [[DDTableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStylePlain];
    v.backgroundColor = UIColor.whiteColor;
    v.alwaysBounceVertical = YES;
    [v registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    if(configBlock){
        configBlock(v);
    }
    return v;
}

+ (DDTableView *)createGroupedTableView:(void (^)(DDTableView * _Nonnull tableView))configBlock
{
    DDTableView * v = [[DDTableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStyleGrouped];
    v.backgroundColor = UIColor.whiteColor;
    v.alwaysBounceVertical = YES;
    [v registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    if(configBlock){
        configBlock(v);
    }
    return v;
}

@end
