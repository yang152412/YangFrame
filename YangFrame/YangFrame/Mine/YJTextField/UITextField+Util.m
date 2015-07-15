//
//  UITextField+Util.m
//  neighborhood
//
//  Created by 杨世昌 on 15/1/22.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import "UITextField+Util.h"
#import "NSString+Util.h"

@implementation UITextField (Util)

#pragma mark 移动光标位置

- (void)moveCaretWithRange:(NSRange)range replacementString:(NSString *)string source:(NSString *)source seperator:(NSString *)seperator
{
    if([self conformsToProtocol:@protocol(UITextInput)])
    {
        id<UITextInput>textInput = (id<UITextInput>)self;
        
        // 复制一份 source,改成可变字符串 ，source 是没有格式化的，可以得到当前光标位置
        NSMutableString *cardNo = [[NSMutableString alloc]initWithString:source];
        NSInteger currentIndex = range.location+string.length; // 修改后的位置
        NSString *sub = [cardNo substringToIndex:currentIndex]; // 修改后的 光标之前的字符串，没有格式化
        NSInteger oldSpaceCount = [sub spaceCount];  //  格式化之前的 空格 的个数
        NSString *normalSub = [NSString getNoSpaceString:sub];   // 修改的字符串 去掉所有的空格
        NSString *formatSub = [NSString seperateString:normalSub seperator:seperator]; //  重新格式化 光标之前的字符串
        NSInteger newSpaceCount = [formatSub spaceCount];    // 计算 新空格的个数
        
        NSInteger count = newSpaceCount - oldSpaceCount; // 计算空格差
        
        // 从左边计算 偏移量，移动光标
        UITextPosition *startPos = [textInput positionFromPosition:textInput.beginningOfDocument offset:currentIndex+count];
        [textInput setSelectedTextRange:[textInput textRangeFromPosition:startPos toPosition:startPos]];
    }
}

@end
