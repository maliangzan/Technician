//
//  SYMeViewContrlGetTechInfoApi.m
//  Technician
//
//  Created by TianQian on 2017/6/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMeViewContrlGetTechInfoApi.h"

@implementation SYMeViewContrlGetTechInfoApi
{
    NSString *_url;
}

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        _url = [url copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return _url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

//  一天
- (NSInteger)cacheTimeInSeconds {
    return 0;
}
@end