//
//  NSString+Util.m
//  iYaYa
//
//  Created by Joshua Bassett on 18/06/09.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Util)

- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return @([self intValue]);
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
}

- (NSString *)urlEncode
{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)urlDecode
{
    return [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding
{
	return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

+ (BOOL)isEmptyString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    return string.length == 0;
}


+ (NSString *)stringFromDictValue:(id)dictValue {
    if (!dictValue || [dictValue isKindOfClass:[NSString class]] || [dictValue isKindOfClass:[NSMutableString class]]) {
        return dictValue;
    }
    
    if ([dictValue isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        return [NSString stringWithFormat:@"%@",dictValue];
    }
}

+ (NSString *)emptyStringFromDictValue:(id)dictValue {
    if (![NSString stringFromDictValue:dictValue]) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",dictValue];
    }
}

@end

@implementation NSString (MD5Token)

- (NSString *) MD5TokenString
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}
@end


@implementation NSNumber (NumericValueHack)
- (NSNumber *)numericValue {
	return self;
}
@end

@implementation NSString (Seperator)

#pragma mark - 银行卡号 4 位 分割
+ (NSString*)getFormatCardID:(NSString*)cardID{   // 将卡号转换为4个一空格的卡号
    //    return formatCreditCardNumber(cardID);
    
    NSString *string = [NSString seperateString:cardID seperator:kSeperatorCreditCardNumber];
    return string;
}

+ (NSString*)getNoSpaceString:(NSString*)string{   // 将4个一空格的卡号转为正常的卡号
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return [string stringByTrimmingChar3actersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark 手机号码 3，4，4 分割
+ (NSString*)getFormatMobileNumber:(NSString *)mobileNum
{
    if (mobileNum) {
        NSString *string = [NSString seperateString:mobileNum seperator:kSeperatorMobileNumber];
        return string;
    }else {
        return nil;
    }
    
}

#pragma mark 分割字符串的方法
+ (NSString*)seperateString:(NSString *)string seperator:(NSString *)seperator {
    // 清楚 string 前后空格
    NSCharacterSet* set = [NSCharacterSet whitespaceCharacterSet];
    NSString *newStr = [string stringByTrimmingCharactersInSet:set];
    
    // 字符串为nil或空。则直接返回。
    if (newStr.length == 0) {
        return newStr;
    }
    // seperator 为nil或空。则直接返回。
    if (seperator.length == 0) {
        return string;
    }
    // 把 分割的 要求字符串 分成数组
    NSArray *seperatorArr = [seperator componentsSeparatedByString:@","];
    NSString *normalStr = [NSString getNoSpaceString:newStr];
    NSMutableArray* array = [NSMutableArray array];
    
    // 放子 字符串
    NSMutableString* subStr = [[NSMutableString alloc] initWithCapacity:1];
    // 默认起始位置
    int seperatorIndex = 0;
    int location = 0;
    // 遍历 字符串
    @autoreleasepool {
        for (NSInteger i = 0; i < normalStr.length; i++)
        {
            // 获取 需要的 长度
            int length = [[seperatorArr objectAtIndex:seperatorIndex] intValue];
            NSRange r = NSMakeRange(location, 1);
            
            // 获取每一位 字符，并加到 字符串中
            NSString *str = [normalStr substringWithRange:r];
            [subStr appendString:str];
            
            // 子字符串达到长度，就加到数组中
            if (subStr.length == length) {
                [array addObject:subStr];
                // 取下一个长度
                if (seperatorIndex != seperatorArr.count-1) {
                    seperatorIndex++;
                }
                // 重新 初始化 子字符串
                subStr = [[NSMutableString alloc] initWithCapacity:1];
            }
            else if (i == normalStr.length -1) {
                // 把剩下的字符串 也放到数组中
                [array addObject:subStr];
            }
            
            location++;
        }
    }
    
    
    // 把 分割后的数组，中间加上空格，拼成字符串
    NSString *formatStr =[array componentsJoinedByString:@" "];
    return  [formatStr stringByTrimmingCharactersInSet:set];
}

- (NSInteger)spaceCount {
    NSArray *arr = [self componentsSeparatedByString:@" "];
    NSInteger count = arr.count - 1;
    if (count < 0) {
        count = 0;
    }
    return count;
}

@end
