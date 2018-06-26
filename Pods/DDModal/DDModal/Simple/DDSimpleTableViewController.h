//
//  DDSimpleTableViewController.h
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimplePopTableViewController.h"

@interface DDSimpleTableViewController : DDSimplePopTableViewController

@property (nonatomic,strong) NSArray * items;
@property (nonatomic,copy) NSString * itemTitleKeyPath;
@property (nonatomic,assign) CGFloat fixedRowHeight;  //固定行高，当>0时，将会自动适配窗口高度

@end
