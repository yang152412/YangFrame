//
//  UIButton+YJActionSheetButton.h
//  neighborhood
//
//  Created by 杨世昌 on 15/1/28.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YJ_COL_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIButton (YJActionSheetButton)

+ (instancetype)actionSheetDestructiveButtonWithTitle:(NSString*)title;
+ (instancetype)actionSheetCancelButtonWithTitle:(NSString*)title;
+ (instancetype)actionSheetOtherButtonWithTitle:(NSString*)title;

@end
