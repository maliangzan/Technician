//
//  UIView+JMNib.h
//  JMCategory
//
//  Created by xserver on 15/7/1.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JMNib)

+ (instancetype)allocWithNibName:(NSString *)name;

//  反正 同名的 nib 文件的view
+ (instancetype)allocWithNibSameClassName;

//  返回 同名的 nib 文件
+ (UINib *)nibWithSameClassName;
@end
