//
//  JYRequestCompressorApi.m
//  Printer
//
//  Created by Dragon on 16/1/20.
//  Copyright © 2016年 爱聚印. All rights reserved.
//

#import "JYRequestCompressorApi.h"
#import "ASIDataCompressor.h"

//#import <YTKNetworkAgent.h>

@implementation JYRequestCompressorApi

//- (YTKRequestMethod)requestMethod {
//    return YTKRequestMethodPost;
//}
//
//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeHTTP;
//}

- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

//- (NSDictionary *)requestHeaderFieldValueDictionary {
//    return @{@"Accept-Encoding" :@"gzip",
//             @"Content-Encoding":@"gzip",};
//}

- (NSURLRequest *)buildCustomUrlRequest {
    
    NSString *url;
//    = [[YTKNetworkAgent sharedInstance] buildRequestUrl:self];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                   timeoutInterval:[self requestTimeoutInterval]];

    NSDictionary *argument;
//    = [self requestArgument];
    if (argument) {
        
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:argument options:0 error:&error];
        if (error) {
            return nil;
        }
        
        data = [ASIDataCompressor compressData:data error:&error];
        if (error) {
            return nil;
        }
        
        [mutableRequest setHTTPBody:data];
        [mutableRequest setValue:[@(data.length) stringValue] forHTTPHeaderField:@"Content-Length"];
    }
    
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [mutableRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [mutableRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [mutableRequest setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    
    return mutableRequest;
}


@end
