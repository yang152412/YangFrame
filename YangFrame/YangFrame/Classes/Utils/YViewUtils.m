//
//  UPXViewUtils.m
//  UPClientV3
//
//  Created by Yang on 13-5-22.
//
//

#import "YViewUtils.h"

@implementation YViewUtils


+ (void)drawImage:(UIImage *)image rect:(CGRect)rect
{
    CGSize  size    = image.size;
    CGFloat originX = (NSInteger)(rect.origin.x + (rect.size.width  - size.width)  / 2);
    CGFloat originY = (NSInteger)(rect.origin.y + (rect.size.height - size.height) / 2);
    [image drawInRect:CGRectMake(originX, originY, size.width, size.height)];
}



+ (UIViewController*)viewControllerOfClass:(Class)cls
{
    UIViewController* result = nil;
    UINavigationController* controller =  (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSArray* vcArr =controller.viewControllers;
        
    NSEnumerator *enumerator = [vcArr reverseObjectEnumerator];
    for (UIViewController* vc in enumerator) {
        if ([vc isKindOfClass:cls]) {
            result = vc;
            break;
        }
    }
    return result;
}


+ (UIViewController*)findUIViewController:(UIResponder*)responder
{
    id nextResponder = [responder nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]])
    {
        return [YViewUtils findUIViewController:nextResponder];
    }
    else
    {
        return nil;
    }
}


+ (UIViewController*)findRootController:(UIView*)view
{
    UIViewController* result  = [self findUIViewController:view];
    if (result)
    {
        return result;
    }
    
    for (UIView *subView in view.subviews)
    {
        result = [YViewUtils findUIViewController:subView];
        if (result != nil)
        {
            return result;
        }
    }
    return nil;
    
}



+ (UIView *)findFirstResponder:(UIView*)view
{
    if (view.isFirstResponder)
    {
        return view;
    }
    
    for (UIView *subView in view.subviews)
    {
        UIView *firstResponder = [YViewUtils findFirstResponder:subView];
        if (firstResponder != nil)
        {
            return firstResponder;
        }
    }
    
    return nil;
}




+ (NSArray *)editableTextInputsInView:(UIView*)view
{
    
    NSMutableArray *textInputs = [[NSMutableArray alloc] init];
    for (UIView *subview in view.subviews)
    {
        BOOL isTextField = [subview isKindOfClass:[UITextField class]] & !subview.hidden;
        BOOL isEditableTextView = [subview isKindOfClass:[UITextView class]] && [(UITextView *)subview isEditable]& !subview.hidden;
        if (isTextField || isEditableTextView)
            [textInputs addObject:subview];
        else
            [textInputs addObjectsFromArray:[self editableTextInputsInView:subview]];
    }
    return textInputs;
}

//去掉输入框中的 markedText

+ (void)deleteMarkedTextWithView:(id<UITextInput>) inputView{
    if (!inputView.markedTextRange.isEmpty) {
        [inputView replaceRange:inputView.markedTextRange withText:@""];
    }
}


@end
