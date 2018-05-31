//
//  DDLoopTableView.m
//  DDToolBoxDemo
//
//  Created by brown on 2018/4/25.
//  Copyright © 2018年 ABiang. All rights reserved.

//  ---- copy https://github.com/DaMingShen/SUTableView ----

#import "DDLoopTableView.h"

@interface DDLoopTableViewDataSource : NSObject

@property (nonatomic,weak) id receiver;
@property (nonatomic,weak) id middler;

@end

@implementation DDLoopTableViewDataSource

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.middler respondsToSelector:aSelector]) return self.middler;
    if ([self.receiver respondsToSelector:aSelector]) return self.receiver;
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.middler respondsToSelector:aSelector]) return YES;
    if ([self.receiver respondsToSelector:aSelector]) return YES;
    return [super respondsToSelector:aSelector];
}

@end

@interface DDLoopTableView()

@property (nonatomic, assign) NSInteger actualRows;
@property (nonatomic, strong) DDLoopTableViewDataSource * loopDataSource;

@end

@implementation DDLoopTableView

- (void)layoutSubviews {
    [self resetContentOffsetIfNeeded];
    [super layoutSubviews];
}

- (void)resetContentOffsetIfNeeded {
    CGPoint contentOffset  = self.contentOffset;
    //scroll over top
    if (contentOffset.y < 0.0) {
        contentOffset.y = self.contentSize.height / 3.0;
    }
    //scroll over bottom
    else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) {
        contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height;
    }
    [self setContentOffset: contentOffset];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource{
    self.loopDataSource.receiver = dataSource;
    [super setDataSource:(id<UITableViewDataSource>)self.loopDataSource];
}

- (DDLoopTableViewDataSource *)loopDataSource{
    if(!_loopDataSource){
        _loopDataSource = [[DDLoopTableViewDataSource alloc] init];
        _loopDataSource.middler = self;
    }
    return _loopDataSource;
}

#pragma mark - Delegate Method Override
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    self.actualRows = [self.loopDataSource.receiver tableView:tableView numberOfRowsInSection:section];
    return self.actualRows * 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath * actualIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.loopDataSource.receiver tableView:tableView cellForRowAtIndexPath:actualIndexPath];
}

@end
