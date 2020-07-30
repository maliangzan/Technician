//
//  CFNotificationHelper.h
//  Printer
//
//  Created by Dragon on 15/11/2.
//  Copyright © 2015年 爱聚印. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYNotificationHelper : NSObject

@property (nonatomic, assign) BOOL isFromLaunched;  //是否点击通知--应用启动(应用杀死了)
@property (nonatomic, assign) BOOL enableSound;
@property (nonatomic, assign) BOOL enableVibrate;

+ (instancetype)shared;

- (void)setup;


- (void)receiveRemoteNotification:(NSDictionary *)userInfo from:(NSString *)place;

- (void)receiveLocalNotification:(UILocalNotification *)notification;

- (void)receiveLocalChats:(NSArray *)chats;


- (void)handleLaunchChatMessage;

- (void)synchroUnreadBadgeWithCount:(NSInteger)count;


@end
