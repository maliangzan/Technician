//
//  UITableView+JMScroll.m
//  JMCategory
//
//  Created by xserver on 15/3/18.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UITableView+JMScroll.h"

@implementation UITableView (JMScroll)

- (void)silenceScrollToTop {
    self.contentOffset = CGPointZero;
}
- (void)silenceScrollToBottom {
    if (self.contentSize.height > self.frame.size.height) {
        self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
    }
}
@end
