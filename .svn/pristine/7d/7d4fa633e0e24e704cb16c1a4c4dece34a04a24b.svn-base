//
//  SYAppConfig.h
//  PartsMall
//
//  Created by Jim on 16/9/12.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JYUpdateDaemon.h"
@class JYUserMode;

@interface SYAppConfig : NSObject

@property (nonatomic, strong) JYUserMode *me;

@property (nonatomic, copy  ) NSString   *tokenQiniu;
@property (nonatomic, copy  ) NSString   *tokenQiniuAudio;
@property (nonatomic, copy  ) NSString   *tokenQiniuVideo;
@property (nonatomic, strong) NSDate     *tokenQiniuTimeout;
//@property (nonatomic, strong) JYUpdateDaemon *updateDaemon;
@property (nonatomic, copy) void(^goToLoginBlock)();

+ (instancetype)shared;
- (void)setup;
- (void)requestUserInfo;
- (void)getUserTempUid;
- (void)loginWithAccount:(NSString *)account password:(NSString *)password;//登录
- (void)logout;//退出登录
- (void)setupForRequestErrorHandle;//登录互踢

/**< 跳登录并返回原来的界面 Ray*/
- (void)gotoLoginControllerAndBackToCurrentController:(UIViewController*)currentVC;

/**< 返回首页 Ray*/
- (void)backToHomePage;


- (void)requestAudioTransferKey:(NSString *)key result:(void (^)(NSString* audioToken))resultBlock;
@end


@interface SYAppConfig (ChatEvent)

- (void)setupForChat;

@end
