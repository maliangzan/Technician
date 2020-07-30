//
//  SYUserHelper.m
//  Printer
//
//  Created by Dragon on 15/9/9.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "SYUserHelper.h"
//#import "SSKeychain.h"
//#import <SSKeychain.h>
#import "NSString+JMJSON.h"

@implementation SYUserHelper



#pragma mark - User Base Info

#ifdef APP_DEBUG
NSString *kSerUserBase = @"debug-service";

NSString *kPushToken = @"debug-push-token";
#else
NSString *kSerUserBase = @"release-service";

NSString *kPushToken = @"release-push-token";
#endif


+ (NSString *)account {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *identifier = info[@"CFBundleIdentifier"];
    return identifier;
}

+ (JYUserMode *)lastLoginUser {
    
//    NSString *string = [SSKeychain passwordForService:kSerUserBase account:[SYUserHelper account]];
//    if (string.length > 0) {
//        NSDictionary *dic = [string toJSON];
//        if (dic) {
//            JYUserMode *user = [JYUserMode fromJSONDictionary:dic];
//            return user;
//        }
//    }
    return nil;
}

static dispatch_queue_t saveUserQueue;

+ (void)saveLastLoginUser:(JYUserMode *)user {
    
//    if (saveUserQueue == NULL) {
//        saveUserQueue = dispatch_queue_create("FIFO_order", DISPATCH_QUEUE_SERIAL);
//    }
//    
//    dispatch_async(saveUserQueue, ^(){
//        
//        NSError *error;
//        NSDictionary *JSONDictionary = [MTLJSONAdapter JSONDictionaryFromModel:user error:&error];
//    
//        if (error == nil) {
//            NSString *secret = [NSString fromJSONObject:JSONDictionary];
//            [SSKeychain setPassword:secret forService:kSerUserBase account:[SYUserHelper account]];
//        }
//        
//    });
}

//  logout 后，只保留 account，在 lastUserAccount
+ (void)logoutClearUser {
//    [SSKeychain setPassword:@"" forService:kSerUserBase account:[SYUserHelper account]];
}

static NSString *lastAccountKey = @"lastAccount";
+ (NSString *)lastUserAccount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:lastAccountKey];
}

+ (void)logoutSetLastAccount:(NSString *)account {
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:lastAccountKey];
}

@end
