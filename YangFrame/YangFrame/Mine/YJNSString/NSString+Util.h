//
//  NSString+Util.h
//  iYaYa
//
//  Created by Josh Bassett on 18/06/09.
//

#import <Foundation/Foundation.h>


@interface NSString (Util)

- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;
- (NSString *)flattenHTML:(NSString *)html;

- (NSString *)urlEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)urlDecode;
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

@end

@interface NSNumber (NumericValueHack)
- (NSNumber *)numericValue;
@end

// 手机号 分割
#define kSeperatorMobileNumber @"3,4"

@interface NSString (Seperator)

#pragma mark - 银行卡号 4 位 分割
+ (NSString*)getFormatCardID:(NSString*)cardID;

// 去掉 空格
+ (NSString*)getNoSpaceString:(NSString*)string;
#pragma mark 手机号码 3，4，4 分割
+ (NSString*)getFormatMobileNumber:(NSString *)mobileNum;
#pragma mark 分割字符串的方法
+ (NSString*)seperateString:(NSString *)string seperator:(NSString *)seperator;


/**
 *  返回 空格 个数
 *
 *  @return <#return value description#>
 */
- (NSInteger)spaceCount;

@end