//
//  JYRequestNormalApi.m
//  JYCommon
//
//  Created by Dragon on 15/7/1.
//  Copyright (c) 2015年 爱聚印. All rights reserved.
//

#import "JYRequestNormalApi.h"

@implementation JYRequestNormalApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 6;
}

@end
