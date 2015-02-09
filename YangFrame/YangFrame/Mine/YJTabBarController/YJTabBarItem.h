//
//  YJTabBarItem.h
//  YTabbarViewController
//
//  Created by 杨世昌 on 15/1/13.
//  Copyright (c) 2015年 杨世昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTabBarItem : UIView
{
    UIImageView *_itemImageView;
    UIImageView *_badgeBg;
    UILabel *_badgeLabel;
    
    UILabel *_titleLabel;
    
    CGRect _badgeBgFrame;
    CGRect _redPointFrame;
}
@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highlightImage;

@property (nonatomic,assign) BOOL selected;

/**
 *  如果是0，则只显示 小红点。如果是 nil，则不显示
 */
@property (nonatomic,copy) NSString *badgeValue;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIColor *titleNormalColor; // default [UIColor darkGrayColor]
@property (nonatomic,strong) UIColor *titleHighlightColor; // default [UIColor whiteColor]

@end
