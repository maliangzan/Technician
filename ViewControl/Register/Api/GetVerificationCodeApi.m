//
//  GetVerificationCodeApi.m
//  Technician
//
//  Created by TianQian on 2017/4/25.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "GetVerificationCodeApi.h"

@implementation GetVerificationCodeApi
{
    NSString *_phoneNum;
}

- (id)initWithPhoneNum:(NSString *)phoneNUm {
    
    if (self = [super init]) {
        _phoneNum = phoneNUm;
        //        _password = [password jyMD5];
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"phoneNum" : _phoneNum,
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/getSMSCaptcha?";
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
