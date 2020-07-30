//
//  ResetPasswordApi.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ResetPasswordApi.h"

@implementation ResetPasswordApi
{
    NSString *_loginName;
    NSString *_newPwd;
}

- (id)initWithLoginName:(NSString *)loginName newPassword:(NSString *)newPwd{
    
    if (self = [super init]) {
        _loginName = loginName;
        _newPwd = newPwd;
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"phoneNum" : _loginName,
                          @"newPwd" : _newPwd,
                          
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/resetPwd?";
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
