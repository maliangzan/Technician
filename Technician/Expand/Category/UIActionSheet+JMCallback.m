//
//  UIActionSheet+JMCallback.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIActionSheet+JMCallback.h"
#import <objc/runtime.h>

@implementation UIActionSheet (JMCallback)
static char ActionSheetBlockKey;

- (UIActionSheet *)setCompleteBlock:(ActionSheetCompleteBlock)block {
    
    if (block) {
        objc_setAssociatedObject(self, &ActionSheetBlockKey, block, OBJC_ASSOCIATION_COPY);
        __weak id ws = self;
        self.delegate = ws;
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    ActionSheetCompleteBlock block = objc_getAssociatedObject(self, &ActionSheetBlockKey);
    if (block) {
        block(self, buttonIndex);
    }
}
@end
