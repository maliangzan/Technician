//
//  UIAlertView+JMCallback.h
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertCompleteBlock) (UIAlertView *alertView, NSInteger index);
static NSInteger kAlertCancelIndex = 0;


@interface UIAlertView (JMC)

- (UIAlertView *)setCompleteBlock:(AlertCompleteBlock)block;


@end
