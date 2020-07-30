//
//  JYRequestCompressorApi.h
//  Printer
//
//  Created by Dragon on 16/1/20.
//  Copyright © 2016年 是源医学. All rights reserved.
//

#import "YTKRequest.h"
#import "YTKBaseRequest+JYResponse.h"
#import "JYRequestHelper.h"
#import "JYCommand.h"
#import "JYRequestApi.h"

//  带gzip压缩功能
//  HTTP + POST + gzip
@interface JYRequestCompressorApi : JYRequestApi

@end
