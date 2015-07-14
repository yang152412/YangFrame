//
//  UIButton+ContentEdgeInset.m
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import "UIButton+ContentEdgeInsets.h"

@implementation UIButton (ContentEdgeInsets)

- (void)setImage:(UIImage *)anImage title:(NSString *)title titlePosition:(UIViewContentMode)titlePosition additionalSpacing:(CGFloat)additionalSpacing state:(UIControlState)state
{
    self.imageView.contentMode = UIViewContentModeCenter;
    [self setImage:anImage forState:state];
    
    
    self.titleLabel.contentMode = UIViewContentModeCenter;
    [self setTitle:title forState:state];
    
    [self positionLabelRespectToImage:title posititon:titlePosition spacing:additionalSpacing];
}

- (void)positionLabelRespectToImage:(NSString *)title posititon:(UIViewContentMode)position spacing:(CGFloat)spacing
{
//    CGRect titleRect = [self titleRectForContentRect:self.bounds]; //size == (0,0)
    CGRect imageSize = [self imageRectForContentRect:self.bounds];
    UIFont *titleFont = self.titleLabel.font;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: titleFont}];
    
    UIEdgeInsets titleInsets,imageInsets;
    switch (position) {
        case UIViewContentModeTop:
            titleInsets = UIEdgeInsetsMake(-(imageSize.size.height + spacing), -(imageSize.size.width), 0,  0);
            imageInsets = UIEdgeInsetsMake(0,  0,  -(titleSize.height + spacing), -titleSize.width);
            break;
        case UIViewContentModeBottom:
            titleInsets = UIEdgeInsetsMake((imageSize.size.height + spacing), -(imageSize.size.width), 0,  0);
            imageInsets = UIEdgeInsetsMake(0, 0,  (titleSize.height + spacing), -titleSize.width);
            break;
        case UIViewContentModeLeft:
            titleInsets = UIEdgeInsetsMake(0, -(imageSize.size.width*2 +spacing), 0,  0);
            imageInsets = UIEdgeInsetsMake(0, 0,  0, -(titleSize.width*2 + spacing));
            
            break;
        case UIViewContentModeRight:
            titleInsets = UIEdgeInsetsMake(0, 0, 0,  -spacing);
            imageInsets = UIEdgeInsetsMake(0,  -spacing,  0, 0);
            break;
        default:
            titleInsets = UIEdgeInsetsMake(0, 0, 0,  0);
            imageInsets = UIEdgeInsetsMake(0,  0,  0, 0);
            break;
    }
    
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = imageInsets;
}

@end
