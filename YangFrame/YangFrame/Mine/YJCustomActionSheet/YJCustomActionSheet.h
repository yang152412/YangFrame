//
//  UPCCustomActionSheet.h
//  upchat
//
//  Created by Yang Shichang on 14-4-7.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJCustomActionSheetDelegate;
@interface YJCustomActionSheet : UIView
{
    CGFloat _totalHeight;
}
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *actionView;

@property (nonatomic, assign) NSInteger cancelIndex;
@property (nonatomic, assign) id<YJCustomActionSheetDelegate> delegate;

@property (nonatomic, readonly) NSMutableArray *buttonTitles;

- (id)initWithTitle:(NSString *)title delegate:(id<YJCustomActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle;
- (id)initWithTitle:(NSString *)title delegate:(id<YJCustomActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;
- (void)showInView:(UIView *)view;

@end


@protocol YJCustomActionSheetDelegate <NSObject>

@optional
- (void)customActionSheet:(YJCustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end