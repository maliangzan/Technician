//
//  SYUISugar.h
//  JMUIQuickMake
//
//  Created by xserver on 15/4/4.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYUISugar : NSObject 
@end


@interface UIAlertController (SYUISugar)

- (void)showForController:(UIViewController *)ctrl;

@end




#ifndef JMUIQuickMake_SYUISugar_h
#define JMUIQuickMake_SYUISugar_h

NS_INLINE UINavigationController *
SYNavigationCtrl(UIViewController *root) {
    return [[UINavigationController alloc] initWithRootViewController:root];
}



#pragma mark - Button
NS_INLINE UIButton *
SYButton(NSString *title, id target, SEL action) {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    
    if (target != nil) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

#pragma mark - UIBarButtonItem
NS_INLINE UIBarButtonItem *
SYBarItem(NSString *title, id target, SEL action) {
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

NS_INLINE UIBarButtonItem *
SYBarImageItem(UIImage *image, id target, SEL action) {
    return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

NS_INLINE UIBarButtonItem *
SYBarButtonItem(NSString *title, UIBarButtonItemStyle style, id target, SEL action) {
    return [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
}

NS_INLINE UIBarButtonItem *
SYBarViewItem(UIView*view) {
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

/**< 统一大小的item，但是颜色又不要用统一色调，就用图片色调 */
NS_INLINE UIBarButtonItem *
SYBarButtonNormalItem(UIImage *image, UIImage *Himage, id target, SEL action) {
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:Himage forState:UIControlStateHighlighted];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


NS_INLINE UIBarButtonItem *
SYBarButtonNormalItemString(NSString *image, NSString *Himage, id target, SEL action) {
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:Himage] forState:UIControlStateHighlighted];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
#pragma mark - UIAlertController

//NS_INLINE UIAlertController *
//SYAlertCtrl(NSString *title, NSString *message) {
//    return [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//}

//  确定 or 取消
NS_INLINE UIAlertController *
SYAlertCtrl(NSString *title, NSString *message,
            NSString *title1, void(^handle1)(UIAlertAction *action),
            NSString *title2, void(^handle2)(UIAlertAction *action)) {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (title1) {
        [alert addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:handle1]];
    }
    
    if (title2) {
        [alert addAction:[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:handle2]];
    }
    
    return alert;
}

#pragma mark - UIAlertView
NS_INLINE UIAlertView *
SYAlertView(NSString *title, NSString *message, NSString *buttonTitle) {
    return [[UIAlertView alloc] initWithTitle:title
                                      message:message
                                     delegate:nil
                            cancelButtonTitle:nil
                            otherButtonTitles:buttonTitle, nil];
}

NS_INLINE UIAlertView *
SYAlertViewTwo(NSString *title, NSString *message, NSString *cancelTitle, NSString *sureTitle) {
    return [[UIAlertView alloc] initWithTitle:title
                                      message:message
                                     delegate:nil
                            cancelButtonTitle:cancelTitle
                            otherButtonTitles:sureTitle, nil];
}

NS_INLINE UIAlertView *
SYAlertTextInput(NSString *title, NSString *message, NSString *cancelTitle, NSString *sureTitle) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:sureTitle, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    return alert;
}

#pragma mark - UIGestureRecognizer
NS_INLINE UITapGestureRecognizer *
SYTap(id target, SEL action) {
    return [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
}

NS_INLINE UIPanGestureRecognizer *
SYPan(id target, SEL action) {
    return [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
}

NS_INLINE UILongPressGestureRecognizer *
SYLongPress(id target, SEL action) {
    return [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
}


#endif
