//
//  YTKBaseRequest+JYResponse.m
//  Printer
//
//  Created by Dragon on 15/7/29.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "YTKBaseRequest+JYResponse.h"
#import "JYCommand.h"
#import "JYRequestHelper.h"

#import "UIAlertView+JMCallback.h"

@implementation YTKBaseRequest (JYResponse)

- (NSInteger)jyCode {
    
    return [[self.responseJSONObject objectForKey:kPRetcode] intValue];
}

- (BOOL)isSuccess {
    return (kPRetcodeSuccess == [[self.responseJSONObject objectForKey:kPRetcode] integerValue]);
}

- (NSString *)baseErrorMessage {
    return [self.responseJSONObject objectForKey:@"message"];
}

- (NSString *)requestErrorMessage {
    
    //  可能被后台断开了。
//    [[JYRequestHelper shared] isServerCloseWithError:self.requestOperation.error];
//    
//    NSInteger errorCode = self.requestOperation.error.code;
//    if (errorCode == -1005) {
//        return Localized(@"Request_BadNetwork");
//    }
//    
//    return self.requestOperation.error.userInfo[NSLocalizedDescriptionKey];
    return @"";
}

- (BOOL)isCommonErrorAndHandle {
    return [[JYRequestHelper shared] handleErrorWithPacket:self.responseJSONObject];
}

- (NSString *)businessErrorMessage {
    //  子类选择性重载
    return self.baseErrorMessage;
}

/*
    NSString *message;
    switch (self.jyCode) {
        case -1:    message = Localized(@"系统错误");
        default:    message = [super businessErrorMessage];
    }
    return message;
*/
@end
