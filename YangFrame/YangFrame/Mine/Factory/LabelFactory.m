//
//  LabelFactory.m
//  neighborhood
//
//  Created by 杨世昌 on 15/6/9.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "LabelFactory.h"

@implementation LabelFactory

+ (UILabel *)emptyLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UILabel *)normalBlackTextLabel
{
    UILabel *label = [LabelFactory emptyLabel];
    label.textColor = COLOR_SYSTEM_Normal_Black;
    return label;
}

+ (UILabel *)lightBlackTextLabel
{
    UILabel *label = [LabelFactory emptyLabel];
    label.textColor = COLOR_SYSTEM_Light_Black;
    return label;
}

+ (UILabel *)lightGrayTextLabel
{
    UILabel *label = [LabelFactory emptyLabel];
    label.textColor = COLOR_SYSTEM_Light_Gray;
    return label;
}

@end
