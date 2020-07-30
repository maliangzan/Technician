//
//  SYPaymentToBankNextStepApi.m
//  Technician
//
//  Created by TianQian on 2017/5/31.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYPaymentToBankNextStepApi.h"

@implementation SYPaymentToBankNextStepApi
{
    SYPaymentToBankMode *_mode;
    NSString *_tid;
}

- (id)initWithPaymentToBankMode:(SYPaymentToBankMode *)mode {
    
    if (self = [super init]) {
        _mode = mode;
        _tid = [[SYAppConfig shared].me.userID stringValue];
    }
    return self;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    [arg setObject:@"bank" forKey:@"accountType"];

    if (!isNull(_tid)) {
        [arg setObject:_tid forKey:@"tid"];
    }
    
    if (!isNull([_mode.amount stringValue])) {
        [arg setObject:_mode.amount forKey:@"amount"];
    }
    
    if (!isNull(_mode.accountName)) {
        [arg setObject:_mode.accountName forKey:@"accountName"];
    }
    
    if (!isNull(_mode.accountNo)) {
        [arg setObject:_mode.accountNo forKey:@"accountNo"];
    }
    
    if (!isNull([_mode.bankID stringValue])) {
        [arg setObject:[_mode.bankID stringValue] forKey:@"bankId"];
    }
    

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnicianWithdrawCash/withdraw?";
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
