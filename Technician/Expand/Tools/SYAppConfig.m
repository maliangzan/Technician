//
//  SYAppConfig.m
//  PartsMall
//
//  Created by Jim on 16/9/12.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import "SYAppConfig.h"
#import "JYUserMode.h"
//#import "JYLoginApi.h"
#import "SYKeyStrings.h"
#import "SYRequestHelper.h"
//#import "JYLoginCtrl.h"
//#import "JYConstUrls.h"
//#import "JYUUIDManager.h"
//#import "JYGetMineInfoApi.h"
//#import "JYTempUidGetApi.h"
//#import "JYUserLogoutApi.h"
//#import "JYTabBarCtrl.h"
//#import <YTKNetworkConfig.h>
//#import <YTKBaseRequest.h>

@implementation SYAppConfig


+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)setup {
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
//    config.baseUrl = URL_HTTP_Base;
    
    [self getUserTempUid];
    
    // 读取沙盒的账号 密码  并自动登录
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *account = [df objectForKey:accountKey];
    NSString *password = [df objectForKey:passwordKey];
    /**自动登录+检测更新Tina*/
    if (account.length > 0 && password.length > 0) {
        [self loginWithAccount:account password:password];
        [self checkAppUpdate];
    } else {
        [self checkAppUpdate];
        self.me = nil;
    }
}

- (void)checkAppUpdate {
//    [self.updateDaemon pullUpdateInfo];
}


- (void)setupForDatabase {
    
}

/**登录拉取3个接口Tina*/
- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
  
}


- (void)logout {
    /**退出登录Tina*/

}


#pragma mark - getUserInfo
- (void)requestUserInfo {

}

- (void)updateMeWithUser:(JYUserMode *)user {
//    user.SID = self.me.SID;
//    user.UID = self.me.UID;
//    
//    user.passwd = self.me.passwd;
//    user.account = self.me.account;
//    
//    self.me = user;
}

#pragma mark - 同步数据
- (void)getUserTempUid {

}



#pragma mark - 错误处理
- (void)setupForRequestErrorHandle {
    WeakSelf;
    [SYRequestHelper shared].userNomatch = ^() {
        
    };
    
    [SYRequestHelper shared].userTimeout = ^() {
        
    };
    
    [SYRequestHelper shared].userNotFound = ^() {
       
    };
    [SYRequestHelper shared].userRemoveFromComapny = ^(){
      
    };
}

- (void)logoutAction{
    [[SYRequestHelper shared] logout];
}

#pragma mark - web socket & chat

#pragma mark - me
- (JYUserMode *)me {
    if (_me == nil) {
        _me = [[JYUserMode alloc] init];
    }
    return _me;
}


@end
