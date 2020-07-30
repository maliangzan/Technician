//
//  UIView+JMProgress.m
//  JM-iOS-Templet
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 https://github.com/xserver. All rights reserved.
//

#import "UIView+JMProgress.h"
#import <objc/runtime.h>

#import "MBProgressHUD.h"

@implementation UIView (JMProgress)


static char JMProgressKey;
static NSTimeInterval delay = 1;
- (void)setJMHUD:(MBProgressHUD *)JMHUD {
    objc_setAssociatedObject(self, &JMProgressKey, JMHUD, OBJC_ASSOCIATION_RETAIN);
}
- (MBProgressHUD *)JMHUD {
    return objc_getAssociatedObject(self, &JMProgressKey);
}

- (void)createAndAddHUD {
    
    if (self.JMHUD) {
        [self hideHUD];
    }
    
    self.JMHUD = [[MBProgressHUD alloc] initWithView:self];
    self.JMHUD.yOffset = -self.frame.size.height * 0.1;
//    self.JMHUD.userInteractionEnabled = NO;
    [self addSubview:self.JMHUD];
    [self bringSubviewToFront:self.JMHUD];
    
//    self.JMHUD.dimBackground = YES;   //  背影
}

- (void)showCustom:(UIImage *)image afterHideHUD:(NSString *)message {

    [self createAndAddHUD];
    
    self.JMHUD.customView = [[UIImageView alloc] initWithImage:image];
    self.JMHUD.mode = MBProgressHUDModeCustomView;
    self.JMHUD.detailsLabelText = message;
    self.JMHUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    [self.JMHUD show:YES];
    [self.JMHUD hide:YES afterDelay:delay];
}

#pragma mark - 自动消失
- (void)showHUDForSuccess:(NSString *)message {
    [self showCustom:[UIImage imageNamed:@"JMHUD_Success"] afterHideHUD:message];
}
- (void)showHUDForError:(NSString *)message {
    [self showCustom:[UIImage imageNamed:@"JMHUD_Error"] afterHideHUD:message];
}
- (void)showHUDForInfo:(NSString *)message {
    [self showCustom:[UIImage imageNamed:@"JMHUD_Info"] afterHideHUD:message];
}

- (void)showHUDOnlyMessage:(NSString *)message {
    
    [self createAndAddHUD];
    
    self.JMHUD.mode = MBProgressHUDModeText;
    self.JMHUD.detailsLabelText = message;
    self.JMHUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    [self.JMHUD show:YES];
    [self.JMHUD hide:YES afterDelay:delay];
    [self performSelector:@selector(removeHudFromSuper) withObject:nil afterDelay:delay];
}

- (void)removeHudFromSuper {
    if (self.JMHUD.superview) {
        [self.JMHUD removeFromSuperview];
    };
}

#pragma mark - 手动消失
- (void)showHUDWithMessage:(NSString *)message {
    
    [self createAndAddHUD];
    
    self.JMHUD.detailsLabelText = message;
    self.JMHUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    [self.JMHUD show:YES];
}

- (void)hideHUD {
    [self.JMHUD hide:YES];
    [self removeHudFromSuper];
    self.JMHUD = nil;
}

/**
 self.JMHUD.mode =
 MBProgressHUDModeAnnularDeterminate    进度转圈模式
 MBProgressHUDModeDeterminateHorizontalBar      水平进度
 
 float progress = 0.0f;
	while (progress < 1.0f) {
 progress += 0.01f;
 HUD.progress = progress;
 usleep(50000);
	}
 */
@end
