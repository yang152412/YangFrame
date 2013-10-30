//
//  YFontUtils.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "YFontUtils.h"

@implementation YFontUtils

+ (UIFont*)defaultFontWihtSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];
}

+ (UIFont*)defaultFont
{
    return [YFontUtils defaultFontWihtSize:kFontSmallSize];
}

+ (UIFont*)navigationTitleFont
{
    return [UIFont boldSystemFontOfSize:kFontNavigationTitle];
}


+ (UIFont*)navigationButtonFont
{
    return [YFontUtils defaultFontWihtSize:kFontNavigationButton];
}

+ (UIFont*)baseButtonTitleFont
{
    return [YFontUtils defaultFontWihtSize:kFontBaseButtonTitleSize];
}

+ (UIFont*)baseTextFieldFont
{
    return [YFontUtils defaultFontWihtSize:kFontBaseTextFieldSize];
}

@end
