//
//  UIPanGestureRecognizer+JMC.m
//  JMCategory
//
//  Created by xserver on 15/4/6.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIPanGestureRecognizer+JMC.h"
#import <objc/runtime.h>

#define distance 40.0

static char swipeBackKey;
static char swipeLeftKey;
static char swipeRigtKey;

@implementation UIPanGestureRecognizer (JMC)

+ (instancetype)swipeBack {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:pan action:@selector(movePanel:)];
    [pan setMinimumNumberOfTouches:1];
    [pan setMaximumNumberOfTouches:1];
    return pan;
}

- (void)xcDealloc {
    [self removeTarget:self action:@selector(movePanel:)];
    objc_setAssociatedObject(self, &swipeBackKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &swipeLeftKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &swipeRigtKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setSwipeBackBlock:(void(^)())backEvent {
    objc_setAssociatedObject(self, &swipeBackKey, backEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setSwipeLeftBlock:(void(^)())leftEvent {
    objc_setAssociatedObject(self, &swipeLeftKey, leftEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setSwipeRigtBlock:(void(^)())rigtEvent {
    objc_setAssociatedObject(self, &swipeRigtKey, rigtEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (BOOL)execBackEvent {
    return [self execEventWithKey:&swipeBackKey];
}
- (BOOL)execLeftEvent {
    return [self execEventWithKey:&swipeLeftKey];
}
- (BOOL)execRigtEvent {
    return [self execEventWithKey:&swipeRigtKey];
}


- (BOOL)execEventWithKey:(const void *)key {
    
    void(^block)() = objc_getAssociatedObject(self, key);
    
    if (block != nil) {
        block();
        return YES;
    }else{
        return NO;
    }
}

- (void)movePanel:(UIPanGestureRecognizer *)pan {
    
    static BOOL isExec;
    if (pan.state == UIGestureRecognizerStateBegan) {
        isExec = NO;
    }
    
    CGFloat offset = [pan translationInView:pan.view].x;
    if([pan state] == UIGestureRecognizerStateChanged) {
        
        if (isExec) {
            return;
        }
        if (offset > distance) {
            isExec = [self execRigtEvent];
        }
        if (offset < -distance) {
            isExec = [self execLeftEvent];
        }
    }
}

@end
