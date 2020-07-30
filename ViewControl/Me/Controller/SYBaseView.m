//
//  SYBaseView.m
//  Technician
//
//  Created by TianQian on 2017/8/2.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYBaseView.h"

@implementation SYBaseView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    //用来判断点击是否在父view bounds内 如果不在父view内就会直接不去其子view中寻找HitTestView，return返回
//    if ([self pointInside:point withEvent:event]) {
    
        for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subView convertPoint:point fromView:self];
            UIView *hitTestView = [subView hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
        
//    }
    
    return nil;
}

@end
