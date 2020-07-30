//
//  JYConstUrls.h
//  PartsMall
//
//  Created by Jim on 16/9/13.
//  Copyright © 2016年 ijuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYConstUrls : NSObject

extern NSString *const WS_Host;
extern NSInteger const WS_Port;
extern BOOL const WS_Secure;

extern NSString *const URL_App_Update;

extern NSString *const URL_HTTP_Base;
extern NSString *const URL_HTTP_Base_Get;
extern NSString *const URL_HTTP_PIC_BASE;

extern NSString *const URL_Verify;  //  获取验证码地址

extern NSString *const URL_Agreemnet; //用户协议

@end
