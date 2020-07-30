//
//  SYRequestHelper.m
//  Printer
//
//  Created by Dragon on 15/7/28.
//  Copyright (c) 2015年 是源医学. All rights reserved.
//

#import "JYRequestHelper.h"
#import "JYCommand.h"
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

@interface JYRequestHelper ()
@property (nonatomic, copy) NSString *systemVer;
@property (nonatomic, copy) NSNumber *version;
@end

@implementation JYRequestHelper

+ (instancetype)shared {
    static id obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    return obj;
}

- (void)setupWithUser:(JYUserMode *)user {
    if ([user.stateEvaluation isEqualToString:@"ytg"]) {//审核通过
        user.hasJoinIn = YES;
    } else if ([user.stateEvaluation isEqualToString:@"dsh"]) {//待审核
        user.hasJoinIn = YES;
    }else if ([user.stateEvaluation isEqualToString:@"ydj"]) {//已冻结
        user.hasJoinIn = NO;
    }else if ([user.stateEvaluation isEqualToString:@"shbtg"]) {//审核不通过
        user.hasJoinIn = NO;
    }else{
        user.hasJoinIn = NO;
    }
}

- (void)logout {
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

- (NSString *)systemVer {
    if (_systemVer == nil) {
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



#pragma mark - Error Handle
- (BOOL)handleErrorWithPacket:(NSDictionary *)packet {
    
    
    return NO;
}


@end
