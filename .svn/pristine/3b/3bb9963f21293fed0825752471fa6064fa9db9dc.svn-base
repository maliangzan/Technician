//
//  SYRegisterApi.m
//  Technician
//
//  Created by TianQian on 2017/4/25.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYRegisterApi.h"

@implementation SYRegisterApi
{
    NSString *_loginName;
    NSString *_password;
    NSString *_code;
}

- (id)initWithLoginName:(NSString *)loginName password:(NSString *)password verificationCode:(NSString *)code {
    
    if (self = [super init]) {
        _loginName = loginName;
        _password = password;
        _code = code;
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"loginName" : _loginName,
                          @"password" : _password,
                          
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/register.do?";
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
