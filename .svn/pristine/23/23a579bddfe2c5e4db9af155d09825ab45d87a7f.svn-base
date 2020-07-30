//
//  SYUploadIconImageApi.m
//  Technician
//
//  Created by TianQian on 2017/6/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYUploadIconImageApi.h"

@implementation SYUploadIconImageApi{
    NSString *_loginName;
    NSString *_realName;
    NSData *_imageData;
}

- (id)initWithImageData:(NSData *)imageData {
    
    if (self = [super init]) {
        _loginName = [SYAppConfig shared].me.loginName;
        _realName = [SYAppConfig shared].me.realName;
        _imageData = imageData;
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if (!isNull(_loginName)) {
        [arg setObject:_loginName forKey:@"loginName"];
    }
    
    if (!isNull(_realName)) {
        [arg setObject:_realName forKey:@"realName"];
    }else{
        [arg setObject:@"" forKey:@"realName"];
    }
    
    if (_imageData) {
        [arg setObject:_imageData forKey:@"storePic"];
    }

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/setPhoto";
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
