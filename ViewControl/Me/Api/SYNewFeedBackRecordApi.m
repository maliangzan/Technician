//
//  SYNewFeedBackRecordApi.m
//  Technician
//
//  Created by TianQian on 2017/8/9.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYNewFeedBackRecordApi.h"

@implementation SYNewFeedBackRecordApi
{
    NSString *_tid;
}

- (id)initWithSource:(NSString *)source {
    
    if (self = [super init]) {
        _tid = [[SYAppConfig shared].me.userID stringValue];
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    [arg setObject:@"technician" forKey:@"source"];
    
    if (!isNull(_tid)) {
        [arg setObject:_tid forKey:@"createUser"];
    }

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsOpinion/findAll1?";
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
