//
//  UIView+JMShake.m
//  JMCategory
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 pitaya. All rights reserved.
//

#import "UIView+JMShake.h"

@implementation UIView (JMShake)
static NSString *_JMShakeStatusKey = @"JMShakeStatusKey";

- (BOOL)shakeStatus {
    return ([self.layer animationForKey:_JMShakeStatusKey] == nil)? NO : YES;
}

- (void)setShakeStatus:(BOOL)enabled {
    
    if (enabled && ![self shakeStatus]){
        CGFloat rotation          = 0.02;
        CABasicAnimation *shake   = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration            = 0.15;
        shake.autoreverses        = YES;
        shake.repeatCount         = MAXFLOAT;
        shake.removedOnCompletion = NO;
        shake.fromValue           = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
        shake.toValue             = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
        
        [self.layer addAnimation:shake forKey:_JMShakeStatusKey];
    }
    
    if (enabled == NO){
        [self.layer removeAnimationForKey:_JMShakeStatusKey];
    }
}

@end
