//
//  UIView+JMOffset.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIView+JMOffset.h"

@implementation UIView (JMOffset)

- (CGFloat)offsetX {
    return 0;
}
- (CGFloat)offsetY {
    return 0;
}

- (void)setOffsetX:(CGFloat)x {
    self.frame = CGRectMake(self.frame.origin.x + x, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}
- (void)setOffsetY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + y,
                            self.frame.size.width, self.frame.size.height);
}


- (CGFloat)originX {
    return self.frame.origin.x;
}
- (CGFloat)originY {
    return self.frame.origin.y;
}
- (void)setOriginY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y,
                            self.frame.size.width, self.frame.size.height);
}

- (void)setOriginX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

@end
