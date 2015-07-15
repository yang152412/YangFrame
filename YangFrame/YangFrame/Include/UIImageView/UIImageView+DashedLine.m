//
//  UIImageView+DashedLine.m
//  neighborhood
//
//  Created by CC on 14-8-7.
//  Copyright (c) 2014年 iYaYa. All rights reserved.
//

#import "UIImageView+DashedLine.h"

@implementation UIImageView (DashedLine)

- (id)initDashLineWithFrame:(CGRect)frame{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:frame];
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {4,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    UIColor *coloreline = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];//r(156, 156, 156, 1);
    CGContextSetStrokeColorWithColor(line, coloreline.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 5.0);    //开始画线
    CGContextAddLineToPoint(line, frame.size.width, 5.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    return imageView1;
}

@end
