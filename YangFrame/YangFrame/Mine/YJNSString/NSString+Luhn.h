//
//  NSString+Luhn.h
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Luhn)

#pragma mark - Luhn算法验证信用卡卡号是否有效
+ (BOOL)luhnCheck:(NSString *)stringToTest;
#pragma mark - 信用卡 卡号是否合法,里面包含了 Luhn 算法校验
+ (BOOL)isCreditCardLegal:(NSString *)cardNum;

@end
