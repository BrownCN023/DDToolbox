//
//  NSMutableArray+DDNode.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^DDMutableArrayAppendNodeCallback) (void);

typedef NSMutableArray * (^DDMutableArrayAppendExpNode)(BOOL exp,DDMutableArrayAppendNodeCallback callback);




@interface NSMutableArray (DDNode)

@property (nonatomic, strong, readonly) DDMutableArrayAppendExpNode appendNode;
/**
 e.g
 NSMutableArray * marr ...;
 appendNode(exp,^id{
 return NSArray<id> objs; | return id;
 });
 */
@end
