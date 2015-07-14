//
//  CharCountInputTextView.h
//  neighborhood
//
//  Created by 杨世昌 on 15/6/18.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@class CharCountInputTextView;
typedef void(^CharCountInputTextViewTextDidChanged)(CharCountInputTextView *inputTextView,NSString *text);
typedef BOOL(^CharCountInputTextViewShouldBeginEditing)(CharCountInputTextView *inputTextView);
typedef BOOL(^CharCountInputTextViewShouldEndEditing)(CharCountInputTextView *inputTextView);

@interface CharCountInputTextView : UIView<UITextViewDelegate>

//@property (nonatomic,readonly) UIView *contentTextBackgroundView;
@property (nonatomic,readonly) UIPlaceHolderTextView *contentTextView;
@property (nonatomic,readonly) UILabel *textViewRemainCharCountLabel;
@property (nonatomic, strong) UIColor *charCountLabelNormalTextColor;
@property (nonatomic, strong) UIColor *charCountLabelLessThanMinTextColor;
@property (nonatomic, strong) UIColor *charCountLabelMoreThanMaxTextColor;

@property (nonatomic, assign) NSInteger maxInputCount; // default 500
@property (nonatomic, assign) NSInteger minInputCount; // default 15

@property (nonatomic,copy) CharCountInputTextViewTextDidChanged textDidChanged;
@property (nonatomic, copy) CharCountInputTextViewShouldBeginEditing textShouldBeginEditing;
@property (nonatomic, copy) CharCountInputTextViewShouldEndEditing textShouldEndEditing;

- (void)setText:(NSString *)text;
- (NSString *)text;

@end
