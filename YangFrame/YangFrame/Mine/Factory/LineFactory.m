//
//  LineFactory.m
//  neighborhood
//
//  Created by 杨世昌 on 15/6/9.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "LineFactory.h"

@implementation LineFactory

+ (UIView *)lineWithSize:(CGSize)size
{
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [separator setBackgroundColor:COLOR_CELL_LINE];
    return separator;
}

+ (UIView *)verticalLineWithHeight:(CGFloat)height
{
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
    [separator setBackgroundColor:COLOR_CELL_LINE];
    return separator;
}

+ (UIView *)horizontalLineWithWidth:(CGFloat)width
{
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
    [separator setBackgroundColor:COLOR_CELL_LINE];
    return separator;
}

@end
