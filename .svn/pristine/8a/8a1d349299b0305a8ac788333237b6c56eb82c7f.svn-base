//
//  SYForgetPasswordApi.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYForgetPasswordApi.h"

@implementation SYForgetPasswordApi
{
    NSString *_loginName;
    NSString *_idCardNum;
    NSString *_code;
}

- (id)initWithLoginName:(NSString *)loginName idCardNum:(NSString *)idCardNum verificationCode:(NSString *)code {
    
    if (self = [super init]) {
        _loginName = loginName;
        _idCardNum = idCardNum;
        _code = code;
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"phoneNum" : _loginName,
                          @"idNumber" : _idCardNum,
                          
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/verifyPhoneNumAndIdNumber?";
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
