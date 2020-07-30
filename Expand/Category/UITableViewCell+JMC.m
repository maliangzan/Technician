//
//  UITableViewCell+JMC.m
//  JMCategory
//
//  Created by xserver on 16/1/11.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "UITableViewCell+JMC.h"

@implementation UITableViewCell (JMC)

- (UITableView *)jmSuperTableView {
    
    id view = [self superview];
    
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    
    return view;
}

@end
