//
//  TriangleLineFactory.m
//  neighborhood
//
//  Created by 杨世昌 on 15/6/29.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "TriangleLineFactory.h"

@implementation TriangleLineFactory

+ (TriangleLineFactory *)horizontalTriangleLineWithWidth:(CGFloat)width
                               triangleWidth:(CGFloat)triangleWidth
                              triangleHeight:(CGFloat)triangleHeight
                                  edgeInset:(UIEdgeInsets)edgeInset
{
    TriangleLineFactory *separator = [[TriangleLineFactory alloc] initWithFrame:CGRectMake(0, 0, width, triangleHeight + 0.5)];
    separator.triangleEdgeInset = edgeInset;
    separator.triangleHeight = triangleHeight;
    separator.triangleWidth = triangleWidth;
    separator.lineColor = COLOR_CELL_LINE;
    return separator;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.lineColor = COLOR_CELL_LINE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    /**
     *  画三角形
     */
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画三角形
    CGContextMoveToPoint(ctx, 0, self.triangleHeight);
    
    if (self.triangleEdgeInset.left > 0) {
        CGContextAddLineToPoint(ctx, self.triangleEdgeInset.left, self.triangleHeight);
        CGContextAddLineToPoint(ctx, self.triangleEdgeInset.left + self.triangleWidth/2.0, 0);
        CGContextAddLineToPoint(ctx, self.triangleEdgeInset.left + self.triangleWidth, self.triangleHeight);
        CGContextAddLineToPoint(ctx, self.bounds.size.width, self.triangleHeight);
    } else if (self.triangleEdgeInset.right > 0) {
        CGFloat left = self.bounds.size.width - self.triangleEdgeInset.right - self.triangleWidth;
        
        CGContextAddLineToPoint(ctx, left, self.triangleHeight);
        CGContextAddLineToPoint(ctx, left + self.triangleWidth/2.0, 0);
        CGContextAddLineToPoint(ctx, left + self.triangleWidth, self.triangleHeight);
        CGContextAddLineToPoint(ctx, self.bounds.size.width, self.triangleHeight);
    } else {
        CGContextAddLineToPoint(ctx, self.bounds.size.width, self.triangleHeight);
    }
    
    
    // 关闭路径(连接起点和最后一个点)
//    CGContextClosePath(ctx);
    
    //
//    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    [self.lineColor setStroke];
    
    // 3.绘制图形
    CGContextStrokePath(ctx);
}

@end
