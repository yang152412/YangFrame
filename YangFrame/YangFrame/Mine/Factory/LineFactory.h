//
//  LineFactory.h
//  neighborhood
//
//  Created by 杨世昌 on 15/6/9.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineFactory : NSObject

+ (UIView *)lineWithSize:(CGSize)size;
+ (UIView *)verticalLineWithHeight:(CGFloat)height;
+ (UIView *)horizontalLineWithWidth:(CGFloat)width;

@end
