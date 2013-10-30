//
//  YBaseTextField.h
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 定义一般文字输入框左边距 */
#define kBaseTextFieldTextRectLeftMargin 10
#define kBaseTextFieldTextRectRightMargin 0


@interface YBaseTextField : UITextField


@property (nonatomic,retain) UIColor *placeHolderColor;

// 是否可以开始编辑，默认YES，可以编辑。
@property (nonatomic,assign) BOOL canBeginEditting;


@property (nonatomic,copy) NSString *leftText;

@property (nonatomic, assign) NSInteger maxlength;

@end
