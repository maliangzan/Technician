//
//  SYUnionApi.m
//  Technician
//
//  Created by TianQian on 2017/4/27.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUnionApi.h"

@implementation SYUnionApi
{
    NSString *_loginName;
    NSNumber *_idNum;
    NSString *_realName;
    NSNumber *_sex;
    NSString *_dateOfBirthday;
    NSString *_email;
    NSString *_address;
    NSString *_detailAddress;
    NSString *_category;
    NSString *_professionLevel;
    NSNumber *_jobYear;
    NSString *_graduateCollege;
    NSString *_specialityDesc;
    NSString *_picture;
    NSString *_idCardNum;
    
}

- (id)initWithUser:(JYUserMode *)user{
    
    if (self = [super init]) {
        _loginName = user.loginName;
        _idNum = user.userID;
        _realName = user.realName;
        _sex = user.sex;
        _dateOfBirthday = user.dateOfBirth;
        _email = user.email;
        _address = user.address;
        _detailAddress = user.detailAddress;
        _category = user.serviceItem;
        _professionLevel = user.level;
        _jobYear = user.workingYear;
        _graduateCollege = user.university;
        _specialityDesc = user.goodAtIntroduction;
        _idCardNum = user.idCardNo;
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if (_idNum) {
        [arg setObject:_idNum forKey:@"tid"];
    }

    if (_loginName) {
        [arg setObject:_loginName forKey:@"loginName"];//必填
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
    
    if (_idCardNum) {
        [arg setObject:_idCardNum forKey:@"idCardNo"];
    }
    
    if (_address) {
        [arg setObject:_address forKey:@"address"];
    }
    
    if (_category) {
        [arg setObject:_category forKey:@"category"];
    }
    
    if (_professionLevel) {
        [arg setObject:_professionLevel forKey:@"professionLevel"];
    }
    
    if (_jobYear) {
        [arg setObject:_jobYear forKey:@"jobYear"];
    }
    
    if (_graduateCollege) {
        [arg setObject:_graduateCollege forKey:@"graduateCollege"];
    }
    
    if (_specialityDesc) {
        [arg setObject:_specialityDesc forKey:@"specialityDesc"];
    }
    
    if (_detailAddress) {
        [arg setObject:_detailAddress forKey:@"detailAddress"];
    }
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
////    [dic setObject:[self arrayToJson:@[arg]] forKey:@"Union"];
//    NSString *jsonString = [NSString stringWithFormat:@"[{\"loginName\":\"%@\",\"realName\":\"%@\",\"dateOfBirth\":\"%@\",\"sex\":\"%@\",\"email\":\"%@\",\"idCardNo\":\"%@\",\"address\":\"%@\",\"category\":\"%@\",\"professionLevel\":\"%@\",\"jobYear\":\"%@\",\"graduateCollege\":\"%@\",\"specialityDesc\":\"%@\",\"detailAddress\":\"%@\"}]",_loginName,_realName,_dateOfBirthday,_sex,_email,_idCardNum,_address,_category,_professionLevel,_jobYear,_graduateCollege,_specialityDesc,_detailAddress];
//    [dic setObject:jsonString forKey:@"Union"];
    return arg;
}

- (NSString*)arrayToJson:(NSArray *)array
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}


- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/union2?";
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
