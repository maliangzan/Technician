//
//  CFNotificationHelper.m
//  Printer
//
//  Created by Dragon on 15/11/2.
//  Copyright © 2015年 爱聚印. All rights reserved.
//

#import "JYNotificationHelper.h"
//#import "JYWebCtrl.h"
//#import "JYChatSessionContainer.h"
//#import "JYChatSessionCoor.h"
//#import "JYChatCtrl.h"
//#import "JYChatSessionCtrl.h"
//#import "JYChatMode.h"
#import "JYRequestHelper.h"


#import <ReactiveCocoa.h>
#import <AudioToolbox/AudioToolbox.h>

typedef NS_ENUM(NSUInteger, CFNotificationType) {
    CFNotificationTypeChat = 1,
    CFNotificationTypeWeb,
};


@interface JYNotificationHelper ()

@property (nonatomic, assign) BOOL hasLaunchChatMessage;
@property (nonatomic, strong) NSDictionary *launchChatMessage;

@end


@implementation JYNotificationHelper


+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (instancetype)init {
    if (self = [super init]) {
        [self bindData];
    }
    return self;
}

- (void)setup {
    //  nothing
}


- (void)bindData {
    
//    @weakify(self);
//    [[RACObserve([JYChatSessionContainer shared], allChatsUnreadCount) skip:1] subscribeNext:^(id x) {
//        @strongify(self);
//        
//        [self synchroUnreadBadgeWithCount:[x integerValue]];
//    }];
}

/*
    from = didReceiveRemoteNotification or didFinishLaunchingWithOptions
 */
- (void)receiveRemoteNotification:(NSDictionary *)userInfo from:(NSString *)place {
    
    if (! userInfo) {
        return;
    }
    
    NSDictionary *dic = userInfo[@"ijuyin"];
    if (! dic) {
        return;
    }
    id type = dic[@"type"];
    if (! type) {
        return;
    }
    if (! [type isKindOfClass:[NSNumber class]]) {
        return;
    }
    
    if ([place isEqualToString:@"didReceiveRemoteNotification"]) {
        //  正在打开时，收到聊天消息，不处理
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            return;
        }
    }
    
    if ([type integerValue] == CFNotificationTypeChat) {
//TO DO 记得修改好+++++++
//       JYUserMode *user = [JYAppConfig shared].me;
//        if (! user) {
            //  用户没登录，不予处理
//            return;
//        }
    
        //  先存下来，一会在再处理
        self.hasLaunchChatMessage = YES;
        self.launchChatMessage = dic;
    }
}

- (void)handleLaunchChatMessage {
    if (self.hasLaunchChatMessage) {
        self.hasLaunchChatMessage = NO;
        self.isFromLaunched = NO;
        [self handleChatMessage:self.launchChatMessage];
    }
}

- (void)handleChatMessage:(NSDictionary *)dic {


}

- (void)receiveLocalNotification:(UILocalNotification *)notification {
    [self handleChatMessage:notification.userInfo];
}



//MARK:本地推送
- (void)receiveLocalChats:(NSArray *)chats {

//    JYChatMode *chat = [chats lastObject];
//    [self presentLocalChat:chat];
//    
//    for (JYChatMode *chat in chats) {
//    }
}


@end
