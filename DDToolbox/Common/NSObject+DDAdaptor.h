//
//  NSObject+DDAdaptor.h
//  DDToolBoxDemo
//
//  Created by Brown on 2017/11/23.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DDMacro.h"

@class DDLinkAdaptor;
typedef DDLinkAdaptor *(^LinkListAdaptor)(id node);

@interface DDLinkAdaptor : NSObject
@property (nonatomic,strong,readonly) id value;
@property (nonatomic, strong, readonly) LinkListAdaptor iph_def;
@property (nonatomic, strong, readonly) LinkListAdaptor ip4;
@property (nonatomic, strong, readonly) LinkListAdaptor ip5;
@property (nonatomic, strong, readonly) LinkListAdaptor ip6;
@property (nonatomic, strong, readonly) LinkListAdaptor ip6p;
@property (nonatomic, strong, readonly) LinkListAdaptor ipx;
@property (nonatomic, strong, readonly) LinkListAdaptor ipxr;
@property (nonatomic, strong, readonly) LinkListAdaptor ipxsmax;

@end

@interface NSObject (DDAdaptor)

- (id)valueAdaptor:(void (^)(DDLinkAdaptor * linkAdaptor))adaptor;

/**
 eg:
    [self valueAdaptor:^(DDLinkAdaptor *linkAdaptor) {
        linkAdaptor.iph_def(@"a").iph5_5(@"b");
    }];
 */

@end
