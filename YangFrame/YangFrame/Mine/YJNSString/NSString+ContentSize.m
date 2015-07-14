//
//  NSString+ContentSize.m
//  YangFrame
//
//  Created by 杨世昌 on 15/7/14.
//  Copyright (c) 2015年 Yang152412. All rights reserved.
//

#import "NSString+ContentSize.h"

@implementation NSString (ContentSize)

+ (CGSize)contentSizeForString:(NSString *)string font:(UIFont *)font boundingSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0f) {
        CGSize contentSize = [string sizeWithFont:font
                                constrainedToSize:size
                                    lineBreakMode:lineBreakMode];
        contentSize.height = ceil(contentSize.height);
        contentSize.width = ceil(contentSize.width);
        return contentSize;
    } else {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary * attributes = @{NSFontAttributeName : font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        
        CGSize contentSize = [string boundingRectWithSize:size
                                                  options:(NSStringDrawingTruncatesLastVisibleLine |
                                                           NSStringDrawingUsesLineFragmentOrigin |
                                                           NSStringDrawingUsesFontLeading)
                                               attributes:attributes
                                                  context:nil].size;
        contentSize.height = ceil(contentSize.height);
        contentSize.width = ceil(contentSize.width);
        return contentSize;
    }
}

@end
