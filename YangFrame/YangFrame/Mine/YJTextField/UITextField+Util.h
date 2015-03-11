//
//  UITextField+Util.h
//  neighborhood
//
//  Created by 杨世昌 on 15/1/22.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Util)

#pragma mark 移动光标位置
- (void)moveCaretWithRange:(NSRange)range replacementString:(NSString *)string source:(NSString *)source seperator:(NSString *)seperator;

@end
