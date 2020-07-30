//
//  JYRequestNormalApi.h
//  JYCommon
//
//  Created by Dragon on 15/7/1.
//  Copyright (c) 2015年 爱聚印. All rights reserved.
//

#import "JYRequestApi.h"
#import "YTKBaseRequest+JYResponse.h"
#import "JYRequestHelper.h"
#import "JYCommand.h"


//  普通的请求，没有压缩功能
@interface JYRequestNormalApi : JYRequestApi

//  覆盖
- (YTKRequestMethod)requestMethod;      //  GET
- (YTKRequestSerializerType)requestSerializerType;  //  JSON

@end
