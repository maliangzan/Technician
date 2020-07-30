//
//  UIView+JMScreenshot.m
//  JMCategory
//
//  Created by xserver on 16/4/27.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "UIView+JMScreenshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (JMScreenshot)

- (UIImage *)screenshot_jm {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

@end
