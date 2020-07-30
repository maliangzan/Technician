//
//  SYRequestHelper.m
//  Printer
//
//  Created by Dragon on 15/7/28.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "SYRequestHelper.h"
#import "SYCommand.h"
#import "JYUserMode.h"
#import "SYAppConfig.h"
//#import "JYUUIDManager.h"
#import <sys/utsname.h>
//#import <ReactiveCocoa.h>

#import "UIAlertView+JMCallback.h"


static NSString * kPHeadUserID         = @"uid";
static NSString * kPHeadApiVersion     = @"ver";
static NSString * kPSessionID          = @"sid";
static NSString * kPHeadAppBuildNumber = @"appver";



@interface SYRequestHelper ()
@property (nonatomic, copy) NSString *systemVer;
@property (nonatomic, copy) NSNumber *version;
@end

@implementation SYRequestHelper

+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)setupWithUser:(JYUserMode *)user {
//    _userSID = [user.SID copy];
//    _userUID = [user.UID copy];
}

- (void)logout {
    self.userNomatch  = nil;
    self.userNotFound = nil;
    self.userTimeout  = nil;
    self.userRemoveFromComapny = nil;
    _userUID = nil;
    _userSID = nil;
}


- (BOOL)isServerCloseWithError:(NSError *)error {
    
    if (error.code == -1005) {
        
        if (_userSID == nil || _userSID == nil) {
            
            if (self.userNomatch) {
                self.userNomatch();
            }
            
            return YES;
        }
    }

    return NO;
}


//  websocket header

//  websocket header
- (id)headerForWebsocket:(NSInteger)cmd {
//    id userUID;
//    id userSID;
//    JYUserMode *me = [SYAppConfig shared].me;
//    if (me.hasLogin) {
//        userUID = me.UID;
//    }
//    if (!userUID) {
//        userUID = @(0);
//    }
//    userSID = me.SID.length > 0 ? me.SID:@"";
//    return @{
//             kPHeadCommand  :@(cmd),
//             kPHeadUserID   :userUID,
//             kPSessionID    :userSID,
//             kPHeadAppType  :@(AppType),
//             kPHeadApiVersion:@(AppApiVersion),
//             @"os":@"iOS"
//             };
    return nil;
}

- (id)headerForWebsocketAndLogin {
    //  login packet 比较特别
//    id userUID;
//    id userSID;
//    JYUserMode *me = [SYAppConfig shared].me;
//    if (me.hasLogin) {
//        userUID = me.UID;
//    }
//    if (!userUID) {
//        userUID = @(0);
//    }
//    userSID = me.SID.length > 0 ? me.SID:@"";
//    return @{
//             kPHeadCommand  :@(kCmdLogin),
//             kPHeadUserID   :userUID,
//             kPSessionID    :userSID,
//             kPHeadAppType  :@(AppType),
//             kPHeadApiVersion:@(AppApiVersion),
////             @"tk"  :[JYUserHelper pushToken],
//             @"os"  :@"iOS"
//             };
    return nil;
}

//  未登录用户的 head，HTTP 业务
- (id)headerForHttpUnlogin:(NSInteger)cmd {
//    return @{
//             kPHeadCommand:@(cmd),
//             kPHeadUserID:@(0),               //  未登录为0
//             kPHeadAppBuildNumber: self.version,
//             kPHeadAppType:@(AppType),     //  
//             kPHeadApiVersion:@(AppApiVersion),
//             @"platform":@(AppPlatform),
//             @"os"  :@"iOS",
//             @"model":  self.model,
//             @"sysver": self.systemVer,
//             @"channel":@(AppChannel),
//             };
    return nil;
}


- (NSString *)systemVer {
    if (_systemVer == nil) {
//        _systemVer = [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
        _systemVer = [[UIDevice currentDevice] systemVersion];
    }
    return _systemVer;
}



- (NSString *)model {
    if (_model == nil) {
            struct utsname systemInfo;
            uname(&systemInfo);
            NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        //iPhone
       if ([deviceString isEqualToString:@"iPhone1,1"])    _model= @"iPhone 1G";
       else if ([deviceString isEqualToString:@"iPhone1,2"])    _model= @"iPhone 3G";
       else if ([deviceString isEqualToString:@"iPhone2,1"])    _model= @"iPhone 3GS";
       else if ([deviceString isEqualToString:@"iPhone3,1"])    _model= @"iPhone 4";
       else if ([deviceString isEqualToString:@"iPhone3,2"])    _model= @"Verizon iPhone 4";
       else if ([deviceString isEqualToString:@"iPhone4,1"])    _model= @"iPhone 4S";
       else if ([deviceString isEqualToString:@"iPhone5,1"])    _model= @"iPhone 5";
       else if ([deviceString isEqualToString:@"iPhone5,2"])    _model= @"iPhone 5";
       else if ([deviceString isEqualToString:@"iPhone5,3"])    _model= @"iPhone 5C";
       else if ([deviceString isEqualToString:@"iPhone5,4"])    _model= @"iPhone 5C";
       else if ([deviceString isEqualToString:@"iPhone6,1"])    _model= @"iPhone 5S";
       else if ([deviceString isEqualToString:@"iPhone6,2"])    _model= @"iPhone 5S";
       else if ([deviceString isEqualToString:@"iPhone7,1"])    _model= @"iPhone 6 Plus";
       else if ([deviceString isEqualToString:@"iPhone7,2"])    _model= @"iPhone 6";
       else if ([deviceString isEqualToString:@"iPhone8,1"])    _model= @"iPhone 6s";
       else if ([deviceString isEqualToString:@"iPhone8,2"])    _model= @"iPhone 6s Plus";
   
        else if ([deviceString isEqualToString:@"i386"])          _model = @"Simulator";
        else  if ([deviceString isEqualToString:@"x86_64"])        _model = @"Simulator";
        
        //iPod
       else if ([deviceString isEqualToString:@"iPod1,1"])      _model= @"iPod Touch 1G";
       else if ([deviceString isEqualToString:@"iPod2,1"])      _model= @"iPod Touch 2G";
       else if ([deviceString isEqualToString:@"iPod3,1"])      _model= @"iPod Touch 3G";
       else if ([deviceString isEqualToString:@"iPod4,1"])      _model= @"iPod Touch 4G";
       else if ([deviceString isEqualToString:@"iPod5,1"])      _model= @"iPod Touch 5G";
        
        //iPad
       else if ([deviceString isEqualToString:@"iPad1,1"])      _model= @"iPad";
       else if ([deviceString isEqualToString:@"iPad2,1"])      _model= @"iPad 2 (WiFi)";
       else if ([deviceString isEqualToString:@"iPad2,2"])      _model= @"iPad 2 (GSM)";
       else if ([deviceString isEqualToString:@"iPad2,3"])      _model= @"iPad 2 (CDMA)";
       else if ([deviceString isEqualToString:@"iPad2,4"])      _model= @"iPad 2 (32nm)";
       else if ([deviceString isEqualToString:@"iPad2,5"])      _model= @"iPad mini (WiFi)";
       else if ([deviceString isEqualToString:@"iPad2,6"])      _model= @"iPad mini (GSM)";
       else if ([deviceString isEqualToString:@"iPad2,7"])      _model= @"iPad mini (CDMA)";
        
       else if ([deviceString isEqualToString:@"iPad3,1"])      _model= @"iPad 3(WiFi)";
       else if ([deviceString isEqualToString:@"iPad3,2"])      _model= @"iPad 3(CDMA)";
       else if ([deviceString isEqualToString:@"iPad3,3"])      _model= @"iPad 3(4G)";
       else if ([deviceString isEqualToString:@"iPad3,4"])      _model= @"iPad 4 (WiFi)";
       else if ([deviceString isEqualToString:@"iPad3,5"])      _model= @"iPad 4 (4G)";
       else if ([deviceString isEqualToString:@"iPad3,6"])      _model= @"iPad 4 (CDMA)";
        
       else if ([deviceString isEqualToString:@"iPad4,1"])      _model= @"iPad Air";
       else if ([deviceString isEqualToString:@"iPad4,2"])      _model= @"iPad Air";
       else if ([deviceString isEqualToString:@"iPad4,3"])      _model= @"iPad Air";
       else if ([deviceString isEqualToString:@"iPad5,3"])      _model= @"iPad Air 2";
       else if ([deviceString isEqualToString:@"iPad5,4"])      _model= @"iPad Air 2";
       else if ([deviceString isEqualToString:@"i386"])         _model= @"Simulator";
       else  if ([deviceString isEqualToString:@"x86_64"])      _model= @"Simulator";
        
       else if ([deviceString isEqualToString:@"iPad4,4"]
            ||[deviceString isEqualToString:@"iPad4,5"]
            ||[deviceString isEqualToString:@"iPad4,6"])      _model= @"iPad mini 2";
        
       else if ([deviceString isEqualToString:@"iPad4,7"]
            ||[deviceString isEqualToString:@"iPad4,8"]
            ||[deviceString isEqualToString:@"iPad4,9"])      _model= @"iPad mini 3";
       else                                                   _model= deviceString;
    }
    return _model;
}

- (NSNumber *)version {
    if (_version == nil) {
        
        NSString *str = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
        _version = @([str integerValue]);
    }
    return _version;
}


//  需要登录的 HTTP 请求 Head
- (id)headerForHttpLogin:(NSInteger)cmd {
    
//    NSString *appkey = [JYUUIDManager getUUID];
//    if (self.userUID == nil || self.userSID == nil) {
//        
//        NSDictionary *dic = @{
//                              kPHeadCommand:   @(cmd),
//                              kPHeadAppBuildNumber: self.version,
//                              kPHeadUserID: @(0),
//
//                              kPHeadAppType:@(AppType),
//                              kPHeadApiVersion:@(AppApiVersion),
//                              @"platform":@(AppPlatform),
//                              @"os":     @"iOS",
//                              @"model":  self.model,
//                              @"sysver": self.systemVer,
//                              @"channel":@(AppChannel),
//                              @"app_key":appkey,
//                              @"lang":lang(),
//                              };
//        return dic;
//    }
//    
//    NSDictionary *dic = @{
//                          kPHeadCommand:    @(cmd),
//                          kPHeadAppBuildNumber:  self.version,
//                          kPHeadUserID: self.userUID,
//                          kPSessionID:  self.userSID,
//                          kPHeadAppType:@(AppType),
//                          kPHeadApiVersion:@(AppApiVersion),
//                          @"platform":@(AppPlatform),
//                          @"os":     @"iOS",
//                          @"model":  self.model,
//                          @"sysver": self.systemVer,
//                          @"channel":@(AppChannel),
//                          @"app_key":appkey,
//                          @"lang":lang(),
//                          };
//    return dic;
    return nil;
}


#pragma mark - Error Handle
- (BOOL)handleErrorWithPacket:(NSDictionary *)packet {
    
    NSInteger code = [[packet objectForKey:kPRetcode] integerValue];
    if (ERR_SID_NOMATCH == code) {
        if (self.userNomatch) {
            self.userNomatch();
            return YES;
        }
    }
    if (ERR_SID_TIMEOUT == code) {
        if (self.userTimeout) {
            self.userTimeout();
            return YES;
        }
    }
    if (ERR_User_Not_Found == code) {
        if (self.userRemoveFromComapny) {
            self.userRemoveFromComapny();
            return YES;
        }
    }
    if (ERR_SID_NOLOGIN == code) {
        if (self.userNotFound) {
            self.userNotFound();
            return YES;
        }
    }
    if (99 == code) {
        return YES;
    }
    return NO;
}


@end
