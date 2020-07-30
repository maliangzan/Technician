//
//  SYQueryWithdrawalRecordApi.m
//  Technician
//
//  Created by TianQian on 2017/5/31.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYQueryWithdrawalRecordApi.h"

@implementation SYQueryWithdrawalRecordApi
{
    NSString *_tid;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    _tid = [[SYAppConfig shared].me.userID stringValue];

    if (!isNull(_tid)) {
        [arg setObject:_tid forKey:@"tid"];
    }

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnicianWithdrawCash/getWithdraws?";
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
