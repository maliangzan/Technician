//
//  UINavigationController+JMPop.m
//  JMCategory
//
//  Created by xserver on 15/11/27.
//  Copyright © 2015年 pitaya. All rights reserved.
//

#import "UINavigationController+JMPop.h"

@implementation UINavigationController (JMPop)

- (UIViewController *)popViewControllerWithCount:(NSInteger)count {
    
    if (count >= self.viewControllers.count) {
        return nil;
    }
    
    NSInteger index = self.viewControllers.count - count -1;    //  count = 1
    if (index < 0) {
        index = 0;
    }
    UIViewController *target = [self.viewControllers objectAtIndex:index];
    [self popToViewController:target animated:YES];
    return target;
}

@end
