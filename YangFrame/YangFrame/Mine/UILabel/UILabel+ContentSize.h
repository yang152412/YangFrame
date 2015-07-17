//
//  UILabel+ContentSize.h
//  neighborhood
//
//  Created by BlackDev on 11/12/13.
//  Copyright (c) 2013 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(ContentSize)

- (CGSize)contentSize;// 用处不大
- (CGSize)adjustContentSizeToSize:(CGSize)size;

- (CGSize)adjustContentSizeToMaxWidth;
- (CGSize)adjustContentSizeToWidth:(CGFloat)width;
- (CGSize)adjustContentSizeToMaxHeight;
- (CGSize)adjustContentSizeToHeight:(CGFloat)height;

@end
