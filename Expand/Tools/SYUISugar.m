//
//  SYUISugar.m
//  JMUIQuickMake
//
//  Created by xserver on 16/4/11.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "SYUISugar.h"

@implementation SYUISugar

@end


@implementation UIAlertController (SYUISugar)

- (void)showForController:(UIViewController *)ctrl {
    
    if (ctrl == nil) {
        ctrl = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    [ctrl presentViewController:self animated:YES completion:nil];
}

@end
