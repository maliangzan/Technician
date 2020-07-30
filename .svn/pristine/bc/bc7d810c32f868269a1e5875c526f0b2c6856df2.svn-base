//
//  JYAppData.h
//  Printer
//
//  Created by Dragon on 16/2/22.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JYMode;

@interface JYAppData : NSObject

+ (instancetype)shared;

- (void)setupForCurrentUserID:(NSNumber *)uid;
- (void)logout;

#pragma mark - business method
#pragma mark - 系统
- (void)putRegisterRemoteNotificationState:(NSString *)value;
- (NSString *)registerRemoteNotificationState;

- (void)putNotificationPlaySound:(BOOL)value;
- (BOOL)notificationPlaySound;

- (void)putNotificationVibrate:(BOOL)value;
- (BOOL)notificationVibrate;

@end
