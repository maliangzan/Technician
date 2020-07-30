//
//  JYLoginApi.m
//  JYCommon
//
//  Created by Dragon on 15/7/1.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "JYLoginApi.h"
//#import "NSString+JYMD5.h"
//#import "JYUUIDManager.h"

@implementation JYLoginApi {
    NSString *_account;
    NSString *_password;
    NSString *_JPushAppKey;
}

- (id)initWithAccount:(NSString *)account password:(NSString *)password {
    
    if (self = [super init]) {
        _account = account;
        _password = password;
        _JPushAppKey = @"1f8216efc9c89a76dfcebfe1";
//        _password = [password jyMD5];
    }
    return self;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if (_account) {
        [arg setObject:_account forKey:@"loginName"];
    }
    if (_password) {
        [arg setObject:_password forKey:@"password"];
    }
    if (_JPushAppKey) {
        [arg setObject:_JPushAppKey forKey:@"rid"];
    }

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/login.do?";
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
