//
//  SYChangePasswordApi.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYChangePasswordApi.h"

@implementation SYChangePasswordApi
{
    NSString *_loginName;
    NSString *_newPwd;
    NSString *_oldPassword;
}

- (id)initWithLoginName:(NSString *)loginName newPassword:(NSString *)newPwd oldPassword:(NSString *)oldPassword{
    
    if (self = [super init]) {
        _loginName = loginName;
        _newPwd = newPwd;
        _oldPassword = oldPassword;
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"phoneNum" : _loginName,
                          @"newPwd" : _newPwd,
                          @"oldPwd": _oldPassword,
                          
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/changePwd?";
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