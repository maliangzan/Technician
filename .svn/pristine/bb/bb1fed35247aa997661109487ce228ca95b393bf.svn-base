//
//  UIAlertView+JMCallback.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIAlertView+JMCallback.h"
#import <objc/runtime.h>

@implementation UIAlertView (JMCallback)
static char AlertViewBlockKey;

- (UIAlertView *)setCompleteBlock:(AlertCompleteBlock)block {
    
    if (block) {
        objc_setAssociatedObject(self, &AlertViewBlockKey, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    AlertCompleteBlock block = objc_getAssociatedObject(self, &AlertViewBlockKey);
    if (block) {
        block(self, buttonIndex);
    }
}
@end
