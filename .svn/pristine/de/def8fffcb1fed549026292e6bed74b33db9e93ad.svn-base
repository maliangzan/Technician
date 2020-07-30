//
//  UINavigationController+JMSwizzle.m
//  Printer
//
//  Created by Dragon on 16/3/15.
//  Copyright © 2016年 是源医学. All rights reserved.
//

#import "UINavigationController+JMSwizzle.h"
#import "NSObject+JMSwizzle.h"
#import <objc/runtime.h>

@implementation UINavigationController (JMSwizzle)

static char const * const kDelegateMyself;
- (BOOL)delegateMyself {
    return [objc_getAssociatedObject(self, kDelegateMyself) boolValue];
}
- (void)setDelegateMyself:(BOOL)delegateMyself {
    objc_setAssociatedObject(self, kDelegateMyself, [NSNumber numberWithBool:delegateMyself], OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - pushTransition
static char const * const kPushTransition;
- (id)pushTransition {
    return objc_getAssociatedObject(self, kPushTransition);
}
- (void)setPushTransition:(id)pushTransition {
    objc_setAssociatedObject(self, kPushTransition, pushTransition, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - popTransition
static char const * const kPopTransition;
- (id)popTransition {
    return objc_getAssociatedObject(self, kPopTransition);
}
- (void)setPopTransition:(id)popTransition {
    objc_setAssociatedObject(self, kPopTransition, popTransition, OBJC_ASSOCIATION_RETAIN);
}


//#pragma mark - didAnimation
//static char const * const kDidAnimation;
//- (DidAnimation)didAnimation {
//    return objc_getAssociatedObject(self, kDidAnimation);
//}
//- (void)setDidAnimation:(DidAnimation)didAnimation {
//    objc_setAssociatedObject(self, kDidAnimation, didAnimation, OBJC_ASSOCIATION_COPY);
//}

#pragma mark - load
+ (void)load {
    
    [super load];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            //  勾 viewDidLoad，为了自己 delegate 自己
            //  &  didShowViewController 设置 interactivePopGestureRecognizer.enabled = YES
            [self jm_SwizzleMethod:@selector(viewDidLoad)
                        withMethod:@selector(jm_viewDidLoad) error:nil];
            
            //  为了设置： interactivePopGestureRecognizer.enabled = NO
            [self jm_SwizzleMethod:@selector(pushViewController:animated:)
                        withMethod:@selector(jm_pushViewController:animated:) error:nil];
        };
    });
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController delegateMyself:(BOOL)delegateMyself {
    
    self.delegateMyself = delegateMyself;
//    self.didAnimation  =  ^(){
//  
//    
//    };


    return [self initWithRootViewController:rootViewController];
}

- (void)jm_viewDidLoad {
    
    if (self.delegateMyself) {   
        self.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self jm_viewDidLoad];
}

- (void)dealloc {
    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = nil;
}

//  push 的时候 禁用
- (void)jm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }

    [self jm_pushViewController:viewController animated:animated];
}

//  出来的时候 开启
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    

    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        //  第一个禁用
        if ([navigationController.viewControllers count] == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
           
        } else {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    
//        if (self.didAnimation) {
//             self.didAnimation();
//        }
//    

    
    self.pushTransition = nil;
    self.popTransition  = nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//    
//    return nil;
//}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    } else if (operation == UINavigationControllerOperationPop) {
        return self.popTransition;
    }
    
    return nil;
}



@end

