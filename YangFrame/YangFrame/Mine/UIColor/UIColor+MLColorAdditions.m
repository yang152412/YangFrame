//
//  UIColor+MLColorAdditions.m
//
//  Created by Marius Landwehr on 02.12.12.
//  The MIT License (MIT)
//  Copyright (c) 2012 Marius Landwehr marius.landwehr@gmail.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIColor+MLColorAdditions.h"

@implementation UIColor (MLColorAdditions)


+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    assert(7 == hexString.length);
    assert('#' == [hexString characterAtIndex:0]);
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    
    unsigned redInt = 0;
    NSScanner *redScanner = [NSScanner scannerWithString:redHex];
    [redScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *greenScanner = [NSScanner scannerWithString:greenHex];
    [greenScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *blueScanner = [NSScanner scannerWithString:blueHex];
    [blueScanner scanHexInt:&blueInt];
    
    return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (UIColor *) colorWithHexString: (NSString *) hexString
{
    return [UIColor colorWithHexString:hexString alpha:1.0];
}


+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha
{
    NSInteger red, green, blue;
    
    blue = hex & 0x0000FF;
    green = ((hex & 0x00FF00) >> 8);
    red = ((hex & 0xFF0000) >> 16);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

#pragma mark -
#pragma mark 从字符串生成UIColor

/*
+ (UIColor*)colorWithHexString: (NSString *) str
{
    NSString *tmp = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([tmp length] < 8){
        DDERROR(@"colorWithHexString len < 8: %@",str);
        return nil;
    }
    
    if ([tmp hasPrefix:@"0X"]){
        tmp = [tmp substringFromIndex:2];
        
    }
    if ([tmp hasPrefix:@"#"]){
        tmp = [tmp substringFromIndex:1];
    }
    
    if ([tmp length] != 8){
        DDERROR(@"colorWithHexString len < 8: %@",str);
        return nil;
    }
    
    unsigned long color = strtoul([tmp UTF8String],0,16);
    float a = ((float)((color & 0xFF000000) >> 24))/255.0;
    float r = ((float)((color & 0xFF0000) >> 16))/255.0;
    float g = ((float)((color & 0xFF00) >> 8))/255.0;
    float b = ((float)(color & 0xFF))/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
*/

@end
