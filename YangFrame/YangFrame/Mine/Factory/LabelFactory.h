//
//  LabelFactory.h
//  neighborhood
//
//  Created by 杨世昌 on 15/6/9.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelFactory : NSObject

+ (UILabel *)emptyLabel;
+ (UILabel *)normalBlackTextLabel;
+ (UILabel *)lightBlackTextLabel;
+ (UILabel *)lightGrayTextLabel;

@end
