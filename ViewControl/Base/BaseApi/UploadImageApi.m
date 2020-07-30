//
//  UploadImageApi.m
//  Solar
//
//  Created by tangqiao on 8/7/14.
//  Copyright (c) 2014 fenbi. All rights reserved.
//

#import "UploadImageApi.h"
#import "AFNetworking.h"

@implementation UploadImageApi {
    UIImage *_image;
    NSString *_loginName;
    NSString *_realName;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
        _loginName = [SYAppConfig shared].me.loginName;
        _realName = isNull([SYAppConfig shared].me.realName) == YES ? @"" : [SYAppConfig shared].me.realName;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    
    if (!isNull(_loginName)) {
        [arg setObject:_loginName forKey:@"loginName"];
    }
    [arg setObject:_realName forKey:@"realName"];

    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsTechnician/setPhoto";
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"image";
        NSString *formKey = @"storePic";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)jsonValidator {
    return @{ @"imageId": [NSString class] };
}

- (NSString *)responseImageId {
    NSDictionary *dict = self.responseJSONObject;
    return dict[@"imageId"];
}

@end
