//
//  SYRequestHelper.h
//  Printer
//
//  Created by Dragon on 15/7/28.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserMode.h"

/**
 Request & Response 
 
 */
@interface JYRequestHelper : NSObject

@property (nonatomic, readonly, copy) id userUID;
@property (nonatomic, readonly, copy) id userSID;

@property (nonatomic, copy) NSString *qiniuToken;

//  用户 sid 不匹配
@property (nonatomic, copy) void(^userNomatch)();

//  用户 sid 超时
@property (nonatomic, copy) void(^userTimeout)();

//  用户 sid 超时
@property (nonatomic, copy) void(^userNotFound)();

// 退出企业--被删除
@property (nonatomic, copy) void(^userRemoveFromComapny)();

@property (nonatomic, copy) NSString *model;


- (void)setupWithUser:(JYUserMode *)user;
- (void)logout;
+ (instancetype)shared;



/**
 *  被服务器 cloes
 */
- (BOOL)isServerCloseWithError:(NSError *)error;


#pragma mark - Header
//  websocket header
- (id)headerForWebsocket:(NSInteger)cmd;

- (id)headerForWebsocketAndLogin;

//  未登录用户的 head，HTTP 业务
- (id)headerForHttpUnlogin:(NSString *)cmdType;

//  需要登录的 HTTP 请求 Head
- (id)headerForHttpLogin:(NSString *)cmdType;


#pragma mark - Error Handle
/**
 业务错误处理 总的入口，负责处理一般性错误。
 
 @param packet 业务数据包
 
 @return 是否处理
 */
- (BOOL)handleErrorWithPacket:(NSDictionary *)packet;


@end
