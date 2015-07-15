//
//  NSString+Luhn.m
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import "NSString+Luhn.h"

@implementation NSString (Luhn)

#pragma mark - Luhn算法验证信用卡卡号是否有效
/* luhn 算法 http://www.pbc.gov.cn/rhwg/20001801f102.htm
 LUHN算法，主要用来计算信用卡等证件号码的合法性。
 1、从卡号最后一位数字开始,偶数位乘以2,如果乘以2的结果是两位数，将两个位上数字相加保存。
 2、把所有数字相加,得到总和。
 3、如果信用卡号码是合法的，总和可以被10整除。
 */
+ (NSMutableArray*)charArrayFromString:(NSString *)string {
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [characters addObject:ichar];
    }
    return characters;
}
+ (BOOL)luhnCheck:(NSString *)stringToTest {
    NSMutableArray *stringAsChars = [self charArrayFromString:stringToTest];
    BOOL isOdd = YES;
    int oddSum = 0;
    int evenSum = 0;
    for (NSInteger i = [stringToTest length] - 1; i >= 0; i--) {
        int digit = [(NSString *)[stringAsChars objectAtIndex:i] intValue];
        if (isOdd) {
            oddSum += digit;
        }
        else {
            //            evenSum += digit/5 + (2*digit) % 10;
            // 上面一句话分为下面三句话
            digit = digit*2;
            int even = digit / 10 + digit % 10;
            evenSum = evenSum + even;
        }
        isOdd = !isOdd;
    }
    return ((oddSum + evenSum) % 10 == 0);
}

+ (BOOL)isCreditCardLegal:(NSString *)cardNum
{
    BOOL isLegal = NO;
    BOOL isMatch  = Y_REGEXP(cardNum, kCreditCardPredicate);
    if (isMatch) {
        // luhn 算法 ，校验 卡号 最后一位 是否合法
        BOOL isLuhnOk = [self luhnCheck:cardNum];
        if (isLuhnOk) {
            isLegal = YES;
        }
    }
    return isLegal;
}


@end
