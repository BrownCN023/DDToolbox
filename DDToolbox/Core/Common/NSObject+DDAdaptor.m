//
//  NSObject+DDAdaptor.m
//  DDToolBoxDemo
//
//  Created by Brown on 2017/11/23.
//  Copyright © 2017年 JTTeam. All rights reserved.
//

#import "NSObject+DDAdaptor.h"
#import <UIKit/UIKit.h>

#define i3_5 CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size)
#define i4_0 CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size)
#define i4_7 CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size)
#define i5_5 CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size)
#define i5_8 CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size)

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

- (LinkListAdaptor)iph3_5{
    return ^(id node){
        if(i3_5){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)iph4_0{
    return ^(id node){
        if(i4_0){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)iph4_7{
    return ^(id node){
        if(i4_7){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)iph5_5{
    return ^(id node){
        if(i5_5){
            self.value = node;
        }
        return self;
    };
}

- (LinkListAdaptor)iph5_8{
    return ^(id node){
        if(i5_8){
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
