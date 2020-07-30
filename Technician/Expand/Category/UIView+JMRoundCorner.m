//
//  UIView+JMRoundCorner.m
//  JMCategory
//
//  Created by xserver on 16/5/13.
//  Copyright © 2016年 pitaya. All rights reserved.
//

#import "UIView+JMRoundCorner.h"

@implementation UIView (JMRoundCorner)

- (void)jmMakeCornerRound {
    CGFloat radius = self.frame.size.width/2;
    [self jmMakeCornerRoundWithRadius:radius];
}

- (void)jmMakeCornerRoundWithRadius:(CGFloat)radius {
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        shape.frame = self.bounds;
        shape.path  = path.CGPath;
        dispatch_async(dispatch_get_main_queue(), ^{
        
            
               self.layer.mask = shape;
        });
        
    });
    
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
//    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
//    shape.frame = self.bounds;
//    shape.path  = path.CGPath;
//    self.layer.mask = shape;
}

@end
