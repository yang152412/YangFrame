//
//  YJAlignmentLabel.h
//  neighborhood
//
//  Created by 杨世昌 on 15/1/16.
//  Copyright (c) 2015年 iYaYa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentMiddle = 0, // default
    VerticalAlignmentTop,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface YJAlignmentLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
