//
//  YTKBaseRequest+JYResponse.h
//  Printer
//
//  Created by Dragon on 15/7/29.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "YTKBaseRequest.h"

//  业务扩展
@interface YTKBaseRequest (JYResponse)

//  返回业务状态码 jy = 聚印
@property (nonatomic, assign, readonly) NSInteger jyCode;

@property (nonatomic, assign, readonly) BOOL isSuccess;
//@property (nonatomic, assign, readonly) BOOL isCommonError;

//  业务错误信息
@property (nonatomic, assign, readonly) NSString *businessErrorMessage;

//  网络请求的错误信息
@property (nonatomic, assign, readonly) NSString *requestErrorMessage;

//  一般性错误
- (BOOL)isCommonErrorAndHandle;

@end
