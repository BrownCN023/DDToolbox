//
//  DDLayoutButton.m
//  TASmartApp
//
//  Created by TongAn001 on 2018/5/3.
//  Copyright © 2018年 ABiang. All rights reserved.
//

#import "DDLayoutButton.h"

@implementation DDLayoutButton

- (void)setLayoutType:(DDLayoutButtonType)layoutType{
    _layoutType = layoutType;
    
    if (layoutType != DDLayoutButtonTypeNormal) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if(_layoutType == DDLayoutButtonTypeTitleLeft){
        CGFloat x = self.layoutInsets.left;
        CGFloat y = self.layoutInsets.top;
        CGFloat width = contentRect.size.width - self.layoutInterval - self.layoutImageSize.width-self.layoutInsets.left-self.layoutInsets.right;
        CGFloat height = contentRect.size.height-self.layoutInsets.top-self.layoutInsets.bottom;
        
        return CGRectMake(x, y, width, height);
        
    }else if(_layoutType == DDLayoutButtonTypeTitleRight){
        CGFloat x = self.layoutInsets.left + self.layoutImageSize.width + self.layoutInterval;
        CGFloat y = self.layoutInsets.top;
        CGFloat width = contentRect.size.width - x - self.layoutInsets.right;
        CGFloat height = contentRect.size.height-self.layoutInsets.top-self.layoutInsets.bottom;
        
        return CGRectMake(x, y, width, height);
    }else if(_layoutType == DDLayoutButtonTypeTitleBottom){
        
        CGFloat x = self.layoutInsets.left;
        CGFloat y = self.layoutInterval + self.layoutImageSize.height +self.layoutInsets.top;
        CGFloat width = contentRect.size.width -self.layoutInsets.left-self.layoutInsets.right;
        CGFloat height = contentRect.size.height - self.layoutInterval - self.layoutImageSize.height-self.layoutInsets.top-self.layoutInsets.bottom;
        
        return CGRectMake(x, y, width, height);
    }else if(_layoutType == DDLayoutButtonTypeTitleTop){
        
        CGFloat x = self.layoutInsets.left;
        CGFloat y = self.layoutInsets.top;
        CGFloat width = contentRect.size.width -self.layoutInsets.left-self.layoutInsets.right;
        CGFloat height = contentRect.size.height - self.layoutInterval - self.layoutImageSize.height-self.layoutInsets.top-self.layoutInsets.bottom;
        
        return CGRectMake(x, y, width, height);
    }
    else{
        
        return [super titleRectForContentRect:contentRect];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if(_layoutType == DDLayoutButtonTypeTitleLeft){
        
        CGFloat x = contentRect.size.width - self.layoutImageSize.width-self.layoutInsets.right;
        CGFloat y =  (contentRect.size.height -  self.layoutImageSize.height)/2.0;
        CGFloat width = self.layoutImageSize.width;
        CGFloat height = self.layoutImageSize.height;
        
        return CGRectMake(x, y, width, height);
    }else if(_layoutType == DDLayoutButtonTypeTitleRight){
        
        CGFloat x = self.layoutInsets.left;
        CGFloat y = (contentRect.size.height -  self.layoutImageSize.height)/2.0;
        CGFloat width = self.layoutImageSize.width;
        CGFloat height = self.layoutImageSize.height;
        
        return CGRectMake(x, y, width, height);
    }else if(_layoutType == DDLayoutButtonTypeTitleBottom){
        
        CGFloat x = (contentRect.size.width-self.layoutImageSize.width)/2.0;
        CGFloat y = self.layoutInsets.top;
        CGFloat width = self.layoutImageSize.width;
        CGFloat height = self.layoutImageSize.height;
        
        return CGRectMake(x, y, width, height);
    }else if(_layoutType == DDLayoutButtonTypeTitleTop){
        
        CGFloat x = (contentRect.size.width-self.layoutImageSize.width)/2.0;
        CGFloat y = contentRect.size.height - self.layoutInsets.bottom-self.layoutImageSize.height;
        CGFloat width = self.layoutImageSize.width;
        CGFloat height = self.layoutImageSize.height;
        
        return CGRectMake(x, y, width, height);
    }else{
        
        return [super imageRectForContentRect:contentRect];
    }
}

@end
