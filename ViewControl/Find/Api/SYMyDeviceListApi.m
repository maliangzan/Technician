//
//  SYMyDeviceListApi.m
//  Technician
//
//  Created by TianQian on 2017/5/23.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMyDeviceListApi.h"

@implementation SYMyDeviceListApi
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