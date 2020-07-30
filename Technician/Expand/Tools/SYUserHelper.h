//
//  SYUserHelper.h
//  Printer
//
//  Created by Dragon on 15/9/9.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYUserMode.h"

@interface SYUserHelper : NSObject

+ (JYUserMode *)lastLoginUser;
+ (void)saveLastLoginUser:(JYUserMode *)user;
+ (void)logoutClearUser;

+ (NSString *)lastUserAccount;
+ (void)logoutSetLastAccount:(NSString *)account;


@end
