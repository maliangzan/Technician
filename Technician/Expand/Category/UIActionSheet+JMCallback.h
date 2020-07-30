//
//  UIActionSheet+JMCallback.h
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (JMCallback)
typedef void(^ActionSheetCompleteBlock) (UIActionSheet *actionSheet, NSInteger index);

- (UIActionSheet *)setCompleteBlock:(ActionSheetCompleteBlock)block;

@end
