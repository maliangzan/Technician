//
//  SYTheHistoricalRecordPaymentToBankNextStepApi.m
//  Technician
//
//  Created by TianQian on 2017/6/1.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYTheHistoricalRecordPaymentToBankNextStepApi.h"

@implementation SYTheHistoricalRecordPaymentToBankNextStepApi
{
    SYAccountMode *_mode;
}

- (id)initWithAccountMode:(SYAccountMode *)mode {
    
    if (self = [super init]) {
        _mode = mode;
    }
    return self;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    if (!isNull([_mode.accountID stringValue])) {
        [arg setObject:_mode.accountID forKey:@"accountId"];
    }

    if (!isNull([_mode.amount stringValue])) {
        [arg setObject:_mode.amount forKey:@"amount"];
    }
    
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnicianWithdrawCash/withdrawByRecords?";
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
