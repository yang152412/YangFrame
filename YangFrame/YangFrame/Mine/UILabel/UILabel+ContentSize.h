//
//  UILabel+ContentSize.h
//  neighborhood
//
//  Created by BlackDev on 11/12/13.
//  Copyright (c) 2013 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(ContentSize)

- (CGSize)contentSize;
- (CGSize)adjustContentSizeToSize:(CGSize)size;

+ (CGSize)contentSizeForString:(NSString *)string font:(UIFont *)font boundingSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode ;

@end
