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

- (CGSize)adjustContentSizeToMaxWidth
{
    return [self adjustContentSizeToWidth:CGFLOAT_MAX];
}

- (CGSize)adjustContentSizeToWidth:(CGFloat)width
{
    CGSize size = [self adjustContentSizeToSize:CGSizeMake(width, self.bounds.size.height)];
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return size;
}

- (CGSize)adjustContentSizeToMaxHeight
{
    return [self adjustContentSizeToHeight:CGFLOAT_MAX];
}

- (CGSize)adjustContentSizeToHeight:(CGFloat)height
{
    CGSize size = [self adjustContentSizeToSize:CGSizeMake(self.bounds.size.width, height)];
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return size;
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



@end
