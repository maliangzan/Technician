//
//  UINavigationController+JMSwizzle.h
//  Printer
//
//  Created by Dragon on 16/3/15.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^DidAnimation) ();


@interface UINavigationController (JMSwizzle)



/**
 *  delegateMyself 很重要的属性，是否自己成为 自己的 UINavigationControllerDelegate
 *  本身用于 Navigation 滑动异常
 *  default = NO.
 */
@property (nonatomic, assign) BOOL delegateMyself;


@property (nonatomic, strong) id pushTransition;
@property (nonatomic, strong) id popTransition;

//@property (nonatomic, copy) DidAnimation didAnimation;


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController delegateMyself:(BOOL)delegateMyself;


@end
