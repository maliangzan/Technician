//
//  JYConstUrls.m
//  PartsMall
//
//  Created by Jim on 16/9/13.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import "JYConstUrls.h"

@implementation JYConstUrls

//#ifdef APP_DEBUG
//#ifdef APP_PRE
////  预发布
////  socket
//NSString *const WS_Host = @"conn-ws-toutiao-pre.yinshuajun.com";
//NSInteger const WS_Port = 23500;
//BOOL const WS_Secure = NO;
//
//NSString *const URL_HTTP_Base   = @"http://conn-http-toutiao-pre.yinshuajun.com:22500";
//NSString *const URL_Verify = @"";
//NSString *const URL_Agreemnet =   @"";
//NSString *const URL_App_Update  = @"";
//
//#else
////  测试
////  socket
//NSString *const WS_Host = @"conn-ws-toutiao-test.yinshuajun.com";
//NSInteger const WS_Port = 23500;
//BOOL const WS_Secure = NO;
//
//NSString *const URL_HTTP_Base   = @"";
//NSString *const URL_Verify = @"";
//NSString *const URL_Agreemnet =   @"";
//NSString *const URL_App_Update  = @"";
//
//#endif

//#else//  正式
//  socket
NSString *const WS_Host = @"172.20.76.144";
NSInteger const WS_Port = 8080;
BOOL const WS_Secure = NO;

//GWX
//NSString *const URL_HTTP_Base   = @"http://172.20.90.24:8080/";
//NSString *const URL_HTTP_PIC_BASE = @"http://172.20.90.24:8080";
//NSString *const URL_HTTP_Base_Get   = @"http://172.20.90.24:8080/Health/app/";
//NSString *const URL_Verify      = @"http://172.20.90.24:8080/Health/app/dsTechnician/";
//NSString *const URL_Agreemnet   = @"";
//NSString *const URL_App_Update  = @"";

//DM
//NSString *const URL_HTTP_Base   = @"http://172.20.76.93:8080/";
//NSString *const URL_HTTP_PIC_BASE = @"http://172.20.76.93:8080";
//NSString *const URL_HTTP_Base_Get   = @"http://172.20.76.93:8080/Health/app/";
//NSString *const URL_Verify      = @"http://172.20.76.93:8080/Health/app/dsTechnician/";
//NSString *const URL_Agreemnet   = @"";
//NSString *const URL_App_Update  = @"";

//test
NSString *const URL_HTTP_Base   = @"http://120.76.119.189:8989/";
NSString *const URL_HTTP_PIC_BASE = @"http://120.76.119.189:8989";
NSString *const URL_HTTP_Base_Get   = @"http://120.76.119.189:8989/Health/app/";
NSString *const URL_Verify      = @"http://120.76.119.189:8989/Health/app/dsTechnician/";
NSString *const URL_Agreemnet   = @"";
NSString *const URL_App_Update  = @"";

//#endif

@end
