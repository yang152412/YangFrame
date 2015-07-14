//
//  NSString+ContentSize.h
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ContentSize)


+ (CGSize)contentSizeForString:(NSString *)string font:(UIFont *)font boundingSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode ;


@end
