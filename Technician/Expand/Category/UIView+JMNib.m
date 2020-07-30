//
//  UIView+JMNib.m
//  JMCategory
//
//  Created by xserver on 15/7/1.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIView+JMNib.h"

@implementation UIView (JMNib)
+ (instancetype)allocWithNibName:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0];
}

+ (instancetype)allocWithNibSameClassName {
    
    NSString *name = NSStringFromClass(self.class);
    return [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] objectAtIndex:0];
}

+ (UINib *)nibWithSameClassName {
    
    NSString *name = NSStringFromClass(self.class);
    return [UINib nibWithNibName:name bundle:nil];
}
@end
