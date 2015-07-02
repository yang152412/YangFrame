//
//  UILabel+ContentSize.m
//  neighborhood
//
//  Created by BlackDev on 11/12/13.
//  Copyright (c) 2013 iYaYa. All rights reserved.
//

#import "UILabel+ContentSize.h"

@implementation UILabel (ContentSize)

- (CGSize)contentSize {
    return [self adjustContentSizeToSize:self.frame.size];
}

- (CGSize)adjustContentSizeToSize:(CGSize)size
{
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0f) {
        CGSize size = [self.text sizeWithFont:self.font
                            constrainedToSize:size
                                lineBreakMode:self.lineBreakMode];
        size.height = ceil(size.height);
        size.width = ceil(size.width);
        return size;
    } else {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        
        NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        
        CGSize contentSize = [self.text boundingRectWithSize:size
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
