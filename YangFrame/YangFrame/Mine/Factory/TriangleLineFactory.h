//
//  TriangleLineFactory.h
//  neighborhood
//
//  Created by 杨世昌 on 15/6/29.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TriangleLineFactory : UIView

@property (nonatomic, assign) CGFloat triangleWidth;
@property (nonatomic, assign) CGFloat triangleHeight;
@property (nonatomic, assign) UIEdgeInsets triangleEdgeInset;
@property (nonatomic, strong) UIColor *lineColor;

+ (TriangleLineFactory *)horizontalTriangleLineWithWidth:(CGFloat)width
                                           triangleWidth:(CGFloat)triangleWidth
                                          triangleHeight:(CGFloat)triangleHeight
                                               edgeInset:(UIEdgeInsets)edgeInset;

@end
