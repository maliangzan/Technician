//
//  SYEditUserInfoApi.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYEditUserInfoApi.h"

@implementation SYEditUserInfoApi
{
    NSNumber *_idNum;
    NSString *_portrait;
    NSString *_realName;
    NSString *_dateOfBirthday;
    NSNumber *_sex;
    NSString *_email;
    NSString *_address;
    NSString *_detailAddress;
    
}

- (id)initWithUser:(JYUserMode *)user{
    
    if (self = [super init]) {
        _idNum = user.userID;
        _portrait = user.portrait;
        _realName = user.realName;
        _dateOfBirthday = user.dateOfBirth;
        _sex = user.sex;
        _email = user.email;
        _address = user.address;
        _detailAddress = user.detailAddress;
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                               @"id" : [SYAppConfig shared].me.userID,
                                                                               
                                                                               }];
    if (_idNum) {
        [arg setObject:_idNum forKey:@"id"];
    }
    if (_portrait) {
        [arg setObject:_portrait forKey:@"portrait"];
    }
    if (_realName) {
        [arg setObject:_realName forKey:@"realName"];
    }
    if (_dateOfBirthday) {
        [arg setObject:_dateOfBirthday forKey:@"dateOfBirth"];
    }
    if (_sex) {
        [arg setObject:_sex forKey:@"sex"];
    }
    if (_email) {
        [arg setObject:_email forKey:@"email"];
    }
    if (_address) {
        [arg setObject:_address forKey:@"address"];
    }
    if (_detailAddress) {
        [arg setObject:_detailAddress forKey:@"detailAddress"];
    }

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
