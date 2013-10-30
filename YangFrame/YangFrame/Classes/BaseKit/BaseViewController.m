//
//  BaseViewController.m
//  YangFrame
//
//  Created by Yang Shichang on 13-10-27.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import "BaseViewController.h"

/* 键盘自动滚动时留的上边 */
#define kUPScrollTopPadding 15

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _pushAnimationType = [[NSMutableString alloc] initWithCapacity:10];
        _pushAnimationSubType = [[NSMutableString alloc] initWithCapacity:10];
        
        _alertArray = [[NSMutableArray alloc] initWithCapacity:5];
        
        _requestOpertation  =  [[NSMutableArray alloc] initWithCapacity:5];
        
        //点击空白 收起键盘
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        _tapGesture.cancelsTouchesInView =  NO;
        _tapGesture.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _deltaY = 0.0f;
    
    if (Y_IOS_VERSION >= 7.0)
    {
        //在ios7上增加偏移量
        _deltaY = kLayoutStatusBarHeight;
        
        //关闭ios7引入的scrollview默认insets
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;

//        //状态栏变回ios6的黑底白字
//        UIView* blackStatusBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutStatusBarHeight)];
//        blackStatusBarBackground.backgroundColor = [UIColor blackColor];
//        [self.view addSubview:blackStatusBarBackground];
//        [self.view sendSubviewToBack:blackStatusBarBackground];
        //白字
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    }
    
    CGRect scrollFrame = self.view.bounds;
    scrollFrame.origin.y +=_deltaY;
    scrollFrame.size.height = kLayoutViewHeight;
    _scrollView.frame = scrollFrame;
//    Y_App.navController.navigationBar.tintColor = Y_COL_RGB(kColorNaviBg);
    [self.view addSubview: _scrollView];
    self.view.backgroundColor = Y_COL_RGB(kColorViewBg);
    [self.view addGestureRecognizer:_tapGesture];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.view removeGestureRecognizer:_tapGesture];
    [_scrollView removeFromSuperview];
    _scrollView.frame = CGRectZero;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}


#pragma mark - setNavigationBarHidden
- (void)setNavigationBarHidden:(BOOL)hidden {
    [Y_App.navController setNavigationBarHidden:hidden animated:NO];
}

- (void)setNavigationBarTitle:(NSString *)title {
    self.title = title;
}

- (void) viewDidAppear:(BOOL)animated
{
    //键盘通知，调整frame, 避免键盘遮挡焦点
    if (Y_IOS_VERSION > 5.0) {
        [Y_NC addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    else{
        [Y_NC addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [Y_NC addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    [Y_NC addObserver:self selector:@selector(textFieldDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    [super viewDidAppear:animated];
}


-(void)viewDidDisappear:(BOOL)animated
{
    if (Y_IOS_VERSION > 5.0) {
        [Y_NC removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    else{
        [Y_NC removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [Y_NC removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
    [Y_NC removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewDidDisappear:animated];
}

#pragma mark
#pragma mark 键盘动作相关

- (void)scrollSelfToVisible:(CGRect)rect animated:(BOOL)animated
{
    CGPoint pt = CGPointZero;
    //scroll view 可视高度
    int visibleHeight = CGRectGetHeight(_scrollView.bounds);
    //scroll view 内容的总高度
    int totalHeight = _scrollView.contentSize.height;
    //控件的上边 + padding
    int topY = CGRectGetMinY(rect) - kUPScrollTopPadding;
    
    if (topY > (totalHeight - visibleHeight)) {
        //屏幕滚动到最底部可以显示下这个rect
        pt.y = totalHeight - visibleHeight;
    }
    else{
        //显示不下, 调整
        pt.y = topY;
    }
    if (pt.y < 0) {
        pt.y = 0;
    }
    [_scrollView setContentOffset:pt animated:YES];
}



//避免焦点遮挡键盘
- (void)moveEditableTextInputToVisible:(UIControl*) responder
{
    if (responder) {
        CGRect rect = [responder convertRect:responder.bounds toView:_scrollView];
        [self scrollSelfToVisible:rect animated:YES];
    }
}



- (void)modifyScrollView:(NSNotification *)notification
{
    BOOL animation = NO;
    NSValue *keyboardBoundsEnd = [notification userInfo][UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect; [keyboardBoundsEnd getValue:&keyboardRect];
    
    int keyboardTop = CGRectGetMinY(keyboardRect);
    
    if (keyboardRect.origin.y < kLayoutScreenHeight) {
        animation = YES;
    }
    
    NSValue *animationDurationValue = [notification userInfo][UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    //键盘消失时的动画如果打开会有scrollview上下多抖动的问题
    if (animation) {
        [UIView beginAnimations:@"move scroll view" context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    }
    
    CGRect frame = _scrollView.frame;
    frame.size.height = keyboardTop - kLayoutNavigationBarHeight - kLayoutStatusBarHeight;
    frame.origin.y = kLayoutNavigationBarHeight + _deltaY;
    _scrollView.frame = frame;
    
    
    if (animation) {
        [UIView commitAnimations];
    }
    
    UIView* firstResponder =  [YViewUtils findFirstResponder:self.view];
    if (firstResponder) {
        CGRect rect = [firstResponder convertRect:firstResponder.bounds toView:_scrollView];
        [self scrollSelfToVisible:rect animated:animation];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    [self modifyScrollView:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self modifyScrollView:notification];
}


- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    [self modifyScrollView:notification];
}

- (void)textFieldDidChangeNotification:(NSNotification *)notification
{   //修复ios7下textfiled最大长度处理bug
    UITextField *textField = [notification object];
    if ([textField isKindOfClass:[YBaseTextField class]]) {
        NSInteger maxlength = ((YBaseTextField *)textField).maxlength;
        if (maxlength > 0 && [textField.text length] > maxlength) {
            textField.text = [textField.text substringToIndex:maxlength];
        }
    }
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - Gesture 手势处理的回调和代理方法

- (void)tapGestureAction:(id)sender
{
    [self hideKeyboard];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //子类可以重写
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark
#pragma mark Start NetWork Acitons

- (NSMutableDictionary*)customHeader
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSArray* languages = [Y_USERDEFAULT objectForKey:@"AppleLanguages"];
    NSString* locale = languages[0];
    dict[@"locale"] = locale;
    return dict;
}


- (NSOperation*)postMessage:(NSString*)msg
{
    DDINFO(@"postMessage: %@",msg);
    
    NSDictionary* header = [self customHeader];
    __block typeof(self) weakSelf = self;
    
    NSOperation* op = [Y_App.netEngine post:msg
                                           header:header
                                completionHandler:^(NSData* data,NSOperation* operation){
                                    NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                    DDINFO(@"postMessage responseString: %@",responseString);
                                    [weakSelf handleJSONString:responseString withOperation:operation];
                                    
                                }
                                     errorHandler:^(NSError* error, NSOperation* operation){
                                         [weakSelf networkErrorCode:error withOperation:operation];
                                     }];
    if (op) {
        [_requestOpertation addObject:op];
    }
    return op;
}

- (void)cancelOperations
{
    // 返回时，取消所有未完成的任务和网络操作，防止Crash
    [_requestOpertation enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         NSOperation *op = (NSOperation*) obj;
         [op cancel];
     }];
    [_requestOpertation removeAllObjects];
}
#pragma mark-
#pragma mark handle json response
- (void)handleJSONString:(NSString*)responseString withOperation:(NSOperation*)operation
{
    @autoreleasepool {
        NSDictionary *responseJSON = [responseString objectFromJSONString];
        if (responseJSON && [responseJSON isKindOfClass:[NSDictionary class]])
        {
            NSString* cmd = responseJSON[kJSONCmdKey];
            NSString* resp = responseJSON[kJSONRespKey];
            
            if (![cmd isKindOfClass:[NSString class]]
                || ![resp isKindOfClass:[NSString class]]) {
                DDERROR(@"requestFinished= %@",responseString);
                [self networkErrorCode:kNetWrongRespError withOperation:operation];
                return;
            }
            
            // 用户登录等交易，业务失败时，resp表示具体的错误类型，比如密码错误
            BOOL exception = ([cmd isEqualToString:@"user.login"]);
            BOOL succeed = (Y_RESPOK(resp));
            
            if (succeed || exception) {
                [self receivedMessage:responseJSON withOperation:operation];
            }
            else {
                NSString* msg = responseJSON[kJSONMsgKey];
                [self messageError:msg code:resp cmd:cmd withOperation:operation];
            }
        }
        else
        {
            DDERROR(@"requestFinished= %@",responseString);
            [self networkErrorCode:kNetWrongRespError withOperation:operation];
        }
    }
}


#pragma mark-
#pragma mark Finish Loading Message or Error

- (void)receivedMessage:(NSDictionary*)msg withOperation:(NSOperation*)operation
{
    [self dismiss];
}

- (void)receivedData:(NSData *)data withOperation:(NSOperation*)operation
{
    DDINFO(@"receivedData: len = %lu",(unsigned long)[data length]);
    [self dismiss];
}

- (void)messageError:(NSString*)error code:(NSString*)code cmd:(NSString *)cmd withOperation:(NSOperation*)operation
{
    DDINFO(@"messageError: cmd = %@, error = %@, code = %@",cmd,error,code);
    
    NSInteger intCode = [code integerValue];
    switch (intCode) {
        case kNetRespUserKickedOut://该用户在其他终端登录，被踢出
        case kNetRespSessionTimeOut://session 失效,登录超时
        {
            
        }
            break;
        default://其他错误
        {
        }
            break;
    }
    
    [self dismiss];
}


- (NSString*)errorMessage:(NSError*)error
{
    NSString* msg = nil;
    NSInteger code = [error code];
    if (code == kNetTimeOut) {
        //The request timed out
    }
    else if(code == kNetSSLError)
    {
    }
    else if(code == kNetWrongResp)
    {
    }
    else
    {
    }
    return msg;
}

- (void)networkErrorCode:(NSError*)error withOperation:(NSOperation*)operation
{
    NSString* errCode = [NSString stringWithFormat:@"%ld", (long)[error code]];
    DDINFO(@"networkError:%@, %@",[error localizedDescription],errCode);
    [self dismiss];
}

#pragma mark -
#pragma mark AlertView, Toast, Loading 相关函数
- (void)showWaitingView:(NSString*)title;
{
    DDINFO(@"showWaitingView : %@", title);
    if (!_waitingView) {
        _waitingView = [[MBProgressHUD alloc] initWithView:Y_App.window];
        _waitingView.userInteractionEnabled = YES;
        _waitingView.removeFromSuperViewOnHide = YES;
        [Y_App.window addSubview:_waitingView];
    }
    if (!Y_IS_NIL(title)) {
        [_waitingView.superview bringSubviewToFront:_waitingView];
        _waitingView.labelText = title;
        [_waitingView show:YES];
    }
}
- (void)hideWaitingView
{
    DDINFO(@"hideWaitingView");
    if (_waitingView) {
        [_waitingView hide:YES];
        [_waitingView removeFromSuperview];
        _waitingView = nil;
    }
}

- (void)showLoadingView
{
    DDINFO(@"showLoadingView");
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView setCenter:CGPointMake(kLayoutScreenWidth/2.0, kLayoutScreenHeight/2.0)];
        [self.view addSubview:_activityView];
    }
    
    [_activityView startAnimating];
    [self.view bringSubviewToFront:_activityView];
}

- (void)hideLoadingView
{
    DDINFO(@"hideLoadingView");
    if (_activityView) {
        [_activityView stopAnimating];
        [_activityView removeFromSuperview];
        _activityView = nil;
    }
}

- (void)showFlashInfo:(NSString*)info
{
    DDINFO(@"showFlashInfo:%@",info);
    if (!Y_IS_NIL(info)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:Y_App.window animated:YES];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = info;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
                           tag:(NSInteger)tag{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:sureButtonTitle, nil];
    
    alertView.delegate = self;
    alertView.tag = tag;
    [alertView show];
}

//UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark dismiss
- (void)dismiss {
    DDINFO(@"dismiss");
    [self hideWaitingView];
    [self hideLoadingView];
}

#pragma mark Push & Pop View Controller
- (void)customPushViewController:(UIViewController *)viewController {
    [Y_App.navController pushViewController:viewController animated:YES];
}

- (void)customPopViewController
{
    [Y_App.navController popViewControllerAnimated:YES];
}

- (void)customPopToViewController:(UIViewController *)viewController
{
    [Y_App.navController popToViewController:viewController animated:YES];
}


@end
