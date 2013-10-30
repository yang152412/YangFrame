//
//  YBaseButton.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "YBaseButton.h"

@implementation YBaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+ (instancetype)commonButtonWithTitle:(NSString*)title
{
    YBaseButton* bt = [self buttonWithType:UIButtonTypeCustom];
    [bt setTitle:title forState:UIControlStateNormal];
//    [bt setTitleColor:Y_COL_RGB(0xffffff) forState:UIControlStateNormal];
//    [bt setTitleColor:Y_COL_RGB(0xffffff) forState:UIControlStateHighlighted];
//    [bt setTitleColor:Y_COL_RGB(0x666666) forState:UIControlStateDisabled];
    //    bt.titleLabel.font  = [UPXFontUtils commonButtonTitleFont];
    UIImage* bg = [Y_GETIMG(@"bt_blue") stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    UIImage* hlBg = [Y_GETIMG(@"bt_blue_tap") stretchableImageWithLeftCapWidth:5 topCapHeight:22];
    UIImage* disableBg = [Y_GETIMG(@"bt_disable") stretchableImageWithLeftCapWidth:4 topCapHeight:22];
    
    [bt setBackgroundImage:bg forState:UIControlStateNormal];
    [bt setBackgroundImage:hlBg forState:UIControlStateHighlighted];
    [bt setBackgroundImage:disableBg forState:UIControlStateDisabled];
    return bt;
}


@end
