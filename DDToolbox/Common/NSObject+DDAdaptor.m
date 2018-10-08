//
//  NSObject+DDAdaptor.m
//  DDToolBoxDemo
//
//  Created by Brown on 2017/11/23.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import "NSObject+DDAdaptor.h"
#import <UIKit/UIKit.h>

@interface DDLinkAdaptor()

@property (nonatomic,strong) id value;

@end

@implementation DDLinkAdaptor

- (void)dealloc{
    //DDPLog(@"dealloc %@",[self class]);
}

- (LinkListAdaptor)iph_def{
    return ^(id node){
        if(!self.value){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ip4{
    return ^(id node){
        if(DD_IS_IPHONE_4){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ip5{
    return ^(id node){
        if(DD_IS_IPHONE_5){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ip6{
    return ^(id node){
        if(DD_IS_IPHONE_6){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ip6p{
    return ^(id node){
        if(DD_IS_IPHONE_6Plus){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ipx{
    return ^(id node){
        if(DD_IS_IPHONE_X){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ipxr{
    return ^(id node){
        if(DD_IS_IPHONE_Xr){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)ipxsmax{
    return ^(id node){
        if(DD_IS_IPHONE_Xs_Max){
            self.value = node;
        }
        return self;
    };
}

@end

@implementation NSObject (DDAdaptor)

- (id)valueAdaptor:(void (^)(DDLinkAdaptor * linkAdaptor))adaptor{
    if(adaptor){
        DDLinkAdaptor * vadaptor = [DDLinkAdaptor new];
        adaptor(vadaptor);
        return vadaptor.value;
    }
    return nil;
}

@end
