//
//  NSObject+DDAdaptor.h
//  DDToolBoxDemo
//
//  Created by Brown on 2017/11/23.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDLinkAdaptor;
typedef DDLinkAdaptor *(^LinkListAdaptor)(id node);

@interface DDLinkAdaptor : NSObject
@property (nonatomic,strong,readonly) id value;
@property (nonatomic, strong, readonly) LinkListAdaptor iph_def;
@property (nonatomic, strong, readonly) LinkListAdaptor iph3_5;
@property (nonatomic, strong, readonly) LinkListAdaptor iph4_0;
@property (nonatomic, strong, readonly) LinkListAdaptor iph4_7;
@property (nonatomic, strong, readonly) LinkListAdaptor iph5_5;
@property (nonatomic, strong, readonly) LinkListAdaptor iph5_8;

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
