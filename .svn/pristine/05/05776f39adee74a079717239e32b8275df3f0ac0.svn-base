//
//  SYUserLogoutApi.m
//  Technician
//
//  Created by TianQian on 2017/4/24.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUserLogoutApi.h"
#import "SYAppConfig.h"

@implementation SYUserLogoutApi
- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if ([SYAppConfig shared].me.loginName) {
        [arg setObject:[SYAppConfig shared].me.loginName forKey:@"loginName"];
    }
  
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/logout.do?";
}

- (NSString *)businessErrorMessage {
    NSString *message;
    switch (self.jyCode) {
        case -1:    message = Localized(@"系统错误");break;
        default:    message = [super businessErrorMessage];break;
    }
    return message;
}
@end
