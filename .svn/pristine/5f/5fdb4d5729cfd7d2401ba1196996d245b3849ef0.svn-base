//
//  SYPaymentSureApi.m
//  Technician
//
//  Created by TianQian on 2017/5/31.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYPaymentSureApi.h"

@implementation SYPaymentSureApi
{
    SYPaymentToBankMode *_mode;
    NSString *_tid;
    NSString *_password;
}

- (id)initWithPaymentToBankMode:(SYPaymentToBankMode *)mode password:(NSString *)pwd{
    
    if (self = [super init]) {
        _mode = mode;
        _tid = [[SYAppConfig shared].me.userID stringValue];
        _password = pwd;
    }
    return self;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    [arg setObject:@"bank" forKey:@"accountType"];
    
    if (!isNull(_tid)) {
        [arg setObject:_tid forKey:@"tid"];
    }
    
    if (!isNull(_mode.accountNo)) {
        [arg setObject:_mode.accountNo forKey:@"accountNo"];
    }
    
    if (!isNull(_mode.accountName)) {
        [arg setObject:_mode.accountName forKey:@"accountName"];
    }
    
    if (!isNull([_mode.bankID stringValue])) {
        [arg setObject:[_mode.bankID stringValue] forKey:@"bankId"];
    }
    
    if (!isNull([_mode.amount stringValue])) {
        [arg setObject:_mode.amount forKey:@"amount"];
    }
    
    if (!isNull(_password)) {
        [arg setObject:_password forKey:@"pwd"];
    }

    return arg;
}

- (NSString *)requestUrl {
//tid=1&accountNo=111111111111&accountName=%25E6%259D%258E%25E6%2598%258E%25E5%258D%259A&accountType=bank&bankId=1&amount=500000&pwd=c33367701511b4f6020ec61ded352059
    return @"Health/app/dsTechnicianWithdrawCash/confirmWithdraw?";
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
