//
//  YFontUtils.h
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFontUtils : NSObject

+ (UIFont*)defaultFontWihtSize:(CGFloat)size;

+ (UIFont*)defaultFont;
+ (UIFont*)navigationTitleFont;
+ (UIFont*)navigationButtonFont;

+ (UIFont*)baseButtonTitleFont;
+ (UIFont*)baseTextFieldFont;

@end
