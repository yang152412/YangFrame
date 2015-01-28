//
//  UPCCustomActionSheet.m
//  upchat
//
//  Created by Yang Shichang on 14-4-7.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
//

#import "YJCustomActionSheet.h"
#import "UIButton+YJActionSheetButton.h"

#define kAnimationDuration 0.3

@implementation YJCustomActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<YJCustomActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle {
    return [self initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
}

- (id)initWithTitle:(NSString *)title delegate:(id<YJCustomActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if (self) {
        _buttonTitles = [[NSMutableArray alloc] init];
        
        self.delegate = delegate;
        // 灰色遮罩
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight+kLayoutStatusBarHeight)];
        [_maskView setAlpha:0.0];
        [_maskView setBackgroundColor:[UIColor blackColor]];
        
        // 点击 取消手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
        [_maskView addGestureRecognizer:tap];
        
        // 内容背景
        _actionView = [[UIView alloc] initWithFrame:CGRectZero];
        [_actionView setBackgroundColor:YJ_COL_RGB(0xe7e7e7)];
        
        CGFloat originX = 19,originY = 22,height = 0;
        
        // add title
        CGFloat labelOriginX = 16;
        CGFloat labelWidth = kLayoutScreenWidth-labelOriginX*2;
        CGRect titleLabelFrame = CGRectMake(labelOriginX, originY, labelWidth, height);
        if (title) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = YJ_COL_RGB(0x6c6c6c);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.numberOfLines = 0;
            //            if (UP_IOS_VERSION >= 7.0) {
            //                height = [title boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:nil context:nil].size.height;
            //            } else {
            height = [title sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
            //            }
            titleLabel.text = title;
            titleLabelFrame.size.height = height;
            titleLabel.frame = titleLabelFrame;
            [_actionView addSubview:titleLabel];
            
            originY = titleLabelFrame.origin.y + titleLabelFrame.size.height+23;
        }
        
        NSInteger buttonTag = 0;
        
        CGFloat width = kLayoutScreenWidth-originX*2;
        // add destructive button
        CGFloat buttonHight = 44;
        CGRect buttonFrame = CGRectMake(originX, originY, width, buttonHight);
        if (destructiveButtonTitle) {
            
            UIButton *destructiveButton = [UIButton actionSheetDestructiveButtonWithTitle:destructiveButtonTitle];
            [destructiveButton setFrame:buttonFrame];
            [destructiveButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
            destructiveButton.tag = buttonTag;
            [destructiveButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_actionView addSubview:destructiveButton];
            
            buttonFrame.origin.y += buttonFrame.size.height + 18;
            [_buttonTitles addObject:destructiveButtonTitle];
            buttonTag++;
        }
        
        // add other button
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) // The first argument isn't part of the varargs list,
        {                                   // so we'll handle it separately.
            
            [self addOtherButtonsAtFrame:buttonFrame title:otherButtonTitles tag:buttonTag];
            
            buttonFrame.origin.y += buttonFrame.size.height + 18;
            [_buttonTitles addObject:otherButtonTitles];
            buttonTag++;
            va_start(argumentList, otherButtonTitles); // Start scanning for arguments after firstObject.
            while ((eachObject = va_arg(argumentList, NSString *))) {// As many times as we can get an argument of type "id"
//                [self addObject: eachObject]; // that isn't nil, add it to self's contents.
                
                [self addOtherButtonsAtFrame:buttonFrame title:eachObject tag:buttonTag];
                
                buttonFrame.origin.y += buttonFrame.size.height + 18;
                [_buttonTitles addObject:eachObject];
                buttonTag++;
            }
            va_end(argumentList);
        }
        
        
        // add cancel button
        if (cancelButtonTitle) {
            UIButton *cancelButton = [UIButton actionSheetCancelButtonWithTitle:cancelButtonTitle];
            [cancelButton setFrame:buttonFrame];
            cancelButton.tag = buttonTag;
            [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
            [cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_actionView addSubview:cancelButton];
            self.cancelIndex  = cancelButton.tag;
            
            [_buttonTitles addObject:cancelButtonTitle];
        }
        
        _totalHeight = buttonFrame.origin.y + buttonFrame.size.height + 25;
        _actionView.frame = CGRectMake(0, kLayoutScreenHeight+kLayoutStatusBarHeight, kLayoutScreenWidth, _totalHeight);
    }
    return self;
}

- (void)addOtherButtonsAtFrame:(CGRect )frame title:(NSString *)title tag:(NSInteger)tag
{
    UIButton *cancelButton = [UIButton actionSheetOtherButtonWithTitle:title];
    [cancelButton setFrame:frame];
    cancelButton.tag = tag;
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_actionView addSubview:cancelButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [self showInView:window];
}

- (void)showInView:(UIView *)view
{
    if (self) {
        [view addSubview:self];
    }else{
        return;
    }
    [view addSubview:_maskView];
    [view addSubview:_actionView];
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [_maskView setAlpha:0.6];
        [_actionView setTop:kLayoutScreenHeight+kLayoutStatusBarHeight-_totalHeight];
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissSelf{
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [_maskView setAlpha:0.0];
        [_actionView setTop:kLayoutScreenHeight+kLayoutStatusBarHeight];
    } completion:^(BOOL finished) {
        [_maskView removeFromSuperview];
        [_actionView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (void)buttonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customActionSheet:clickedButtonAtIndex:)]) {
        [self.delegate customActionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self dismissSelf];
}

@end
