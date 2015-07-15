//
//  CharCountInputTextView.m
//  neighborhood
//
//  Created by 杨世昌 on 15/6/18.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "CharCountInputTextView.h"

@implementation CharCountInputTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxInputCount = 500;
        _minInputCount = 0;
        
//        UIView *textBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        textBg.backgroundColor = [UIColor clearColor];
//        [self addSubview:textBg];
//        _contentTextBackgroundView = textBg;
        
        self.charCountLabelNormalTextColor = [UIColor grayColor];
        self.charCountLabelLessThanMinTextColor = [UIColor grayColor];
        self.charCountLabelMoreThanMaxTextColor = [UIColor colorWithRed:1 green:40.0/255.0 blue:65.0/255.0 alpha:1];
        
        // 字数统计
        _textViewRemainCharCountLabel = [[UILabel alloc] init];
        _textViewRemainCharCountLabel.frame = CGRectMake(0,frame.size.height - 20 - 10, frame.size.width, 20);
        _textViewRemainCharCountLabel.backgroundColor = [UIColor clearColor];
        _textViewRemainCharCountLabel.font = [UIFont systemFontOfSize:12];
        _textViewRemainCharCountLabel.textColor = [UIColor lightGrayColor];
        _textViewRemainCharCountLabel.text = @"您可以输入500个字";
        _textViewRemainCharCountLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textViewRemainCharCountLabel];
        
        _contentTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, _textViewRemainCharCountLabel.frame.origin.y - 3)];
        _contentTextView.placeholder = @"请输入内容";
        _contentTextView.backgroundColor = [UIColor clearColor];
        _contentTextView.delegate = self;
        _contentTextView.font = [UIFont systemFontOfSize:14];
        _contentTextView.textColor = [UIColor blackColor];
        [self addSubview:_contentTextView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self updateCharCountLabel];
}

- (void)updateCharCountLabel
{
    NSString *text = self.contentTextView.text;
    
    if (text.length < self.minInputCount) {
        _textViewRemainCharCountLabel.textColor = self.charCountLabelLessThanMinTextColor;
        _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"加油，还差%lu个字",self.minInputCount-text.length];
    } else if (text.length <= self.maxInputCount) {
        if (self.minInputCount == 0) {
            // 没有最少输入
            _textViewRemainCharCountLabel.textColor = self.charCountLabelNormalTextColor;
            _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"还可以输入%lu个字",self.maxInputCount-text.length];
        } else {
            _textViewRemainCharCountLabel.textColor = self.charCountLabelNormalTextColor;
            _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"真棒，还可以输入%lu个字",self.maxInputCount-text.length];
        }
    } else {
        _textViewRemainCharCountLabel.textColor = self.charCountLabelMoreThanMaxTextColor;
        _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"最多可以输入%li个字",(long)self.maxInputCount];
    }
}

#pragma mark - setter
- (void)setMaxInputCount:(NSInteger)maxInputCount
{
    _maxInputCount = maxInputCount;
}

#pragma mark -
- (void)setText:(NSString *)text
{
    self.contentTextView.text = text;
    [self updateCharCountLabel];
}

- (NSString *)text
{
    return self.contentTextView.text;
}

- (void)clearData
{
    self.contentTextView.text = nil;
}

#pragma mark -- textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.textShouldBeginEditing) {
        return self.textShouldBeginEditing(self);
    } else {
        return YES;
    }
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.textShouldEndEditing) {
        return self.textShouldEndEditing(self);
    } else {
        return YES;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self.contentTextView scrollRangeToVisible:NSMakeRange(self.contentTextView.text.length - 1, 1)];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *rangeStr = [textView textInRange:textView.markedTextRange];
    if (textView.text.length > self.maxInputCount && rangeStr.length == 0) {
        // 延迟到下一个runloop，否则会崩溃
        [self performSelector:@selector(delayCutText) withObject:nil afterDelay:0];
        _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"已经输入%li个字",(long)self.maxInputCount];
    }else
    {
//        if (textView.text.length ==0) {
//            _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"还可以输入%i个字",self.maxInputCount];
//        } else if (self.contentTextView.text.length > self.maxInputCount) {
//            _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"最多可以输入%i个字",self.maxInputCount];
//        } else {
//            _textViewRemainCharCountLabel.text = [NSString stringWithFormat:@"已经输入%@个字",@(textView.text.length)];
//        }
        [self updateCharCountLabel];
        if (self.textDidChanged) {
            self.textDidChanged(self,textView.text);
        }
    }
}

- (void)delayCutText
{
    NSString *origin = [self.contentTextView.text copy];
    NSString *shouldText = [origin substringWithRange:NSMakeRange(0, self.maxInputCount)];
    
    self.contentTextView.text = shouldText;
    if (self.contentTextView.text.length > 0) {
        [self.contentTextView scrollRangeToVisible:NSMakeRange(self.contentTextView.text.length - 1, 1)];
    }
    
    [self updateCharCountLabel];
    
    if (self.textDidChanged) {
        self.textDidChanged(self,self.contentTextView.text);
    }
}

@end
