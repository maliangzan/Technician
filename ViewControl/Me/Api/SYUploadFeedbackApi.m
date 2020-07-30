
//
//  SYUploadFeedbackApi.m
//  Technician
//
//  Created by TianQian on 2017/6/19.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUploadFeedbackApi.h"
#import "SYTimeHelper.h"

@implementation SYUploadFeedbackApi
{
    NSString *_feedBackString;
    NSString *_tid;
    NSString *_submitTime;
}

- (id)initWithFeedBackString:(NSString *)feedBackString {
    
    if (self = [super init]) {
        _tid = [[SYAppConfig shared].me.userID stringValue];
        _feedBackString = feedBackString;
        _submitTime = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    if (!isNull(_feedBackString)) {
        [arg setObject:_feedBackString forKey:@"content"];
    }
    
    [arg setObject:@"technician" forKey:@"source"];
    
    if (!isNull(_tid)) {
        [arg setObject:_tid forKey:@"createUser"];
    }
    
    if (!isNull(_submitTime)) {
        [arg setObject:_submitTime forKey:@"createTime"];
    }
    
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsOpinion/iu?";
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
