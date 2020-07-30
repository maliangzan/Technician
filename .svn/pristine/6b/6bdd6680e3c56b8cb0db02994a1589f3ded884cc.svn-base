//
//  JYCommand.h
//  JYCommon
//
//  Created by Dragon on 15/6/18.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger kPRetcodeSuccess    = 0;
static NSString *kPRetcode           = @"code";



#pragma mark - Head
static NSString * kPHead         = @"head";
static NSString * kPErrorMessage = @"errmsg";
static NSString * kPHeadAppType  = @"apptype";
static NSString * kPHeadCommand  = @"cmd";


//  数据包扩展
@interface NSDictionary (JYCommand)
- (NSInteger)command;
- (NSInteger)retcode;
- (NSString *)errorMessage;
@end

typedef NS_ENUM(NSUInteger, JYCommand) {
    kCmdHeartPint      = 101,
    kCmdHeartPong      = 102,
    
    kCmdLogin          = 0x10012,//  65554
    kCmdLoginRet       = 0x10013,//  65555
    
    kCmdSend           = 0x10016,//  65558
    kCmdSendRet        = 0x10017,//  65559
    
    kCmdPullMessage    = 0x10018,//  65560   主动拉取请求
    kCmdPullMessageRet = 0x10019,//  65561
    kCmdHaveNewMessage = 0x1001A,//  65562   新消息通知
};


//  回包错误码，详情见文档
#define ERR_DB_ERROR        1  //参数缺失
#define ERR_METHOD_ERROR    2  //方法错误


