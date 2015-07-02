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

// 判断空字符串
+ (BOOL)isEmptyString:(NSString *)string;
// 从字典中获取字符串,如果为 nil，null，则返回 nil。
+ (NSString *)stringFromDictValue:(id)dictValue;
// 从字典中获取字符串,如果为 nil，null，则返回 @""。
+ (NSString *)emptyStringFromDictValue:(id)dictValue;

@end

@interface NSString (MD5Token)

- (NSString *) MD5TokenString;

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