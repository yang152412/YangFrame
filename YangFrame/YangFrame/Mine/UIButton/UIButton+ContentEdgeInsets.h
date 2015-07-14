//
//  UIButton+ContentEdgeInset.h
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ContentEdgeInsets)

- (void)setImage:(UIImage *)anImage title:(NSString *)title titlePosition:(UIViewContentMode)titlePosition additionalSpacing:(CGFloat)additionalSpacing state:(UIControlState)state;

@end
