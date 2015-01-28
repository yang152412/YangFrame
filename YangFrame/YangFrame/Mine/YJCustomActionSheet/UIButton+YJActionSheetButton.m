//
//  UIButton+YJActionSheetButton.m
//  neighborhood
//
//  Created by 杨世昌 on 15/1/28.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "UIButton+YJActionSheetButton.h"

@implementation UIButton (YJActionSheetButton)

+ (instancetype)actionSheetDestructiveButtonWithTitle:(NSString*)title
{
    UIButton* bt = [self buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0xffffff) forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0xffffff) forState:UIControlStateHighlighted];
    [bt setTitleColor:YJ_COL_RGB(0x666666) forState:UIControlStateDisabled];
    bt.titleLabel.font  = [UIFont systemFontOfSize:16];
    UIImage* bg = [[UIImage imageNamed:@"cus_actionSheet_destructiveBtn"]
                   stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    UIImage* hlBg = [[UIImage imageNamed:@"cus_actionSheet_destructiveBtn_h"] stretchableImageWithLeftCapWidth:5 topCapHeight:22];
    //    UIImage* disableBg = [UP_GETIMG(@"bt_disable") stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    
    [bt setBackgroundImage:bg forState:UIControlStateNormal];
    [bt setBackgroundImage:hlBg forState:UIControlStateHighlighted];
    //    [bt setBackgroundImage:disableBg forState:UIControlStateDisabled];
    
    bt.exclusiveTouch = YES;
    return bt;
}

+ (instancetype)actionSheetCancelButtonWithTitle:(NSString*)title
{
    UIButton* bt = [self buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0xffffff) forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0xffffff) forState:UIControlStateHighlighted];
    [bt setTitleColor:YJ_COL_RGB(0x666666) forState:UIControlStateDisabled];
    bt.titleLabel.font  = [UIFont systemFontOfSize:16];
    UIImage* bg = [[UIImage imageNamed:@"cus_actionSheet_cancelBtn"] stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    UIImage* hlBg = [[UIImage imageNamed:@"cus_actionSheet_cancelBtn_h"] stretchableImageWithLeftCapWidth:5 topCapHeight:22];
    //    UIImage* disableBg = [UP_GETIMG(@"bt_disable") stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    
    [bt setBackgroundImage:bg forState:UIControlStateNormal];
    [bt setBackgroundImage:hlBg forState:UIControlStateHighlighted];
    //    [bt setBackgroundImage:disableBg forState:UIControlStateDisabled];
    
    bt.exclusiveTouch = YES;
    return bt;
}

+ (instancetype)actionSheetOtherButtonWithTitle:(NSString*)title
{
    UIButton* bt = [self buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0x6c6c6c) forState:UIControlStateNormal];
    [bt setTitleColor:YJ_COL_RGB(0x6c6c6c) forState:UIControlStateHighlighted];
    [bt setTitleColor:YJ_COL_RGB(0x666666) forState:UIControlStateDisabled];
    bt.titleLabel.font  = [UIFont systemFontOfSize:16];
    UIImage* bg = [[UIImage imageNamed:@"cus_actionSheet_otherBtn"] stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    UIImage* hlBg = [[UIImage imageNamed:@"cus_actionSheet_otherBtn_h"] stretchableImageWithLeftCapWidth:5 topCapHeight:22];
    //    UIImage* disableBg = [UP_GETIMG(@"bt_disable") stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    
    [bt setBackgroundImage:bg forState:UIControlStateNormal];
    [bt setBackgroundImage:hlBg forState:UIControlStateHighlighted];
    //    [bt setBackgroundImage:disableBg forState:UIControlStateDisabled];
    
    bt.exclusiveTouch = YES;
    return bt;
}

@end
