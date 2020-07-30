//
//  JYRequestCompressorApi.m
//  Printer
//
//  Created by Dragon on 16/1/20.
//  Copyright © 2016年 是源医学. All rights reserved.
//

#import "JYRequestCompressorApi.h"
//#import "ASIDataCompressor.h"

#import <YTKNetworkAgent.h>

@implementation JYRequestCompressorApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeHTTP;
//}

- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}



@end
