//
//  SYCommand.h
//  JYCommon
//
//  Created by Dragon on 15/6/18.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger kPRetcodeSuccess    = 0;
static NSString *kPRetcode           = @"ret";



#pragma mark - Head
static NSString * kPHead         = @"head";
static NSString * kPErrorMessage = @"errmsg";
static NSString * kPHeadAppType  = @"apptype";
static NSString * kPHeadCommand  = @"cmd";


//  数据包扩展
@interface NSDictionary (SYCommand)
- (NSInteger)command;
- (NSInteger)retcode;
- (NSString *)errorMessage;
@end

typedef NS_ENUM(NSUInteger, SYCommand) {
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
#define ERR_SID_UNFOUND  -10000  //请求头里面没有找到sid
#define ERR_SID_INVALID  -10001  //请求头里面的sid非法
#define ERR_SID_TIMEOUT  -10002  //sid超时
#define ERR_SID_NOLOGIN  -10003  //未登录
#define ERR_SID_NOMATCH  -10004  //不匹配(在别的地方登录了,需要重新登录)
#define ERR_User_Not_Found  -10005   //  用户不存在

#define ERR_DB_ERROR        -10006  //数据库相关错误
#define ERR_ACCESS_DENIED   -10007  //没有权限
#define ERR_PARAM           -10008  //参数错误


//  跳转码
#define MSG_ACT_CODE_Video_Record     6  //视频录制
#define MSG_ACT_CODE_NOTICE_WEB       8  //open web
#define MSG_ACT_CODE_CallPhone        10  //打电话  "ext":{"code":10, "phone":"电话号码", "btn":"按钮标题"}
#define MSG_ACT_CODE_Chat_Audio       16  //语音消息扩展   "ext":{"code":16, "time":消息时长(秒)}

