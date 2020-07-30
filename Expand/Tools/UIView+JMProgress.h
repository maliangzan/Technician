//
//  UIView+JMProgress.h
//  JM-iOS-Templet
//
//  Created by xserver on 15/6/12.
//  Copyright (c) 2015年 https://github.com/xserver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface UIView (JMProgress)
@property (nonatomic, strong) MBProgressHUD *JMHUD;

//  自动消失
- (void)showHUDForSuccess:(NSString *)message;
- (void)showHUDForError:(NSString *)message;
- (void)showHUDForInfo:(NSString *)message;
- (void)showHUDOnlyMessage:(NSString *)message;

//  手动消失
- (void)showHUDWithMessage:(NSString *)message;
- (void)hideHUD;

@end
