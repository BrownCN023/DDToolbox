//
//  NSMutableString+DDNode.h
//  DDTooboxDemo
//
//  Created by abiang on 2018/5/28.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * (^DDMutableStringAppendNodeCallback) (void);
typedef NSMutableString * (^DDMutableStringAppendExpNode)(BOOL exp,DDMutableStringAppendNodeCallback callback);



@interface NSMutableString (DDNode)

@property (nonatomic, strong, readonly) DDMutableStringAppendExpNode appendNode;
/**
 e.g
 mStr.appendNode(exp,@"A").appendNode(exp,@"123");
 */
@end
