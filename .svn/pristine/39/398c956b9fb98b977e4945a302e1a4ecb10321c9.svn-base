//
//  UIView+JMUIViewController.m
//  JMCategory
//
//  Created by xserver on 16/3/16.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "UIView+JMUIViewController.h"

@implementation UIView (JMUIViewController)

/**
 *  @return 这个视图 所属 的 UIViewController
 */
- (UIViewController *)superController {
    
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    } while(next != nil);
    
    return nil;
}

/**
 *  @return 当前Window最上面的 UIViewController
 */
+ (UIViewController *)currentWindowTopViewController {
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //  normal 才是正确的 window
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow * win in windows) {
            if (win.windowLevel == UIWindowLevelNormal) {
                window = win;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    UIViewController *result = [frontView superController];
    if (result == nil) {
        result = window.rootViewController;
    }
    
    return result;
}

@end
