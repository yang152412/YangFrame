//
//  BaseViewController.h
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

// 所有view都加在 _scrollView 上

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    float       _deltaY;//iOS7于iOS6以前的offset=20
    
    UIButton* _btnBack;
    UIButton* _btnLeft;
    UIButton* _btnRight;
    
    UIScrollView* _scrollView;
    UITapGestureRecognizer* _tapGesture;
    
    //记住push动画
    NSMutableString* _pushAnimationType;
    NSMutableString* _pushAnimationSubType;
    
    NSMutableArray* _alertArray;//对话框
    UIActivityIndicatorView* _activityView;
    MBProgressHUD *_waitingView;
    
    NSMutableArray*  _requestOpertation;//目前发出去并未结束的请求队列
}

#pragma mark
#pragma mark 文字输入框/键盘相关处理

-(void)moveEditableTextInputToVisible:(UIControl*) responder;
- (void)hideKeyboard;

#pragma mark
#pragma mark 网络相关

- (NSMutableDictionary*)customHeader;
- (NSOperation*)postMessage:(NSString*)msg;
- (void)receivedMessage:(NSDictionary*)msg withOperation:(NSOperation*)operation;
- (void)receivedData:(NSData*)data withOperation:(NSOperation*)operation;
- (void)messageError:(NSString*)error code:(NSString*)code cmd:(NSString*)cmd withOperation:(NSOperation*)operation;
- (NSString*)errorMessage:(NSError*)error;
- (void)networkErrorCode:(NSError*)error withOperation:(NSOperation*)operation;

- (void)cancelOperations;

#pragma mark -
#pragma mark 对话框/等待框相关函数
- (void)showWaitingView:(NSString*)title;
- (void)showLoadingView;
- (void)hideLoadingView;
- (void)showFlashInfo:(NSString*)info;
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                           tag:(NSInteger)tag;
- (void)dismiss;

//手势回调
#pragma mark Gesture 手势处理
- (void)tapGestureAction:(id)sender;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;


#pragma mark Push & Pop View Controller
- (void)customPushViewController:(UIViewController *)viewController;
- (void)customPopViewController;
- (void)customPopToViewController:(UIViewController *)viewController;

#pragma mark - setNavigationBarHidden
- (void)setNavigationBarHidden:(BOOL)hidden;

@end
