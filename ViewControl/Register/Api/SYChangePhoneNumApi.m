//
//  SYChangePhoneNumApi.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYChangePhoneNumApi.h"

@implementation SYChangePhoneNumApi
{
    NSString *_loginName;
    NSNumber *_idNum;
}

- (id)initWithLoginName:(NSString *)loginName userID:(NSNumber *)idNum{
    
    if (self = [super init]) {
        _loginName = loginName;
        _idNum = idNum;
    }
    return self;
}

- (id)requestArgument {
    
    NSDictionary *arg = @{
                          @"loginName" : _loginName,
                          @"id" : _idNum,
                          
                          };
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/iu?";
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
