//
//  SYUploadServiceTimeApi.m
//  Technician
//
//  Created by TianQian on 2017/6/16.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUploadServiceTimeApi.h"

@implementation SYUploadServiceTimeApi
{
    NSString *_serviceTimeString;
}

- (id)initWithServiceTimeString:(NSString *)serviceTimeString{
    
    if (self = [super init]) {
        _serviceTimeString = serviceTimeString;
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if (!isNull(_serviceTimeString)) {
        [arg setObject:_serviceTimeString forKey:@"ServiceTimes"];
    }
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnicianServiceTime/receive1?";
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
