//
//  SYAddDeviceApi.m
//  Technician
//
//  Created by TianQian on 2017/6/28.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYAddDeviceApi.h"

@implementation SYAddDeviceApi
{
    NSString *_deviceNum;
    NSString *_deviceName;
    NSNumber *_userID;
    NSString *_deviceType;
    NSString *_bluetoothName;
}

- (id)initWithDeviceMode:(SYDeviceMode *)device {
    
    if (self = [super init]) {
        _userID = [SYAppConfig shared].me.userID;
        _deviceNum = device.deviceNum;
        _deviceName = device.deviceName;
        _deviceType = @"负压养生仪";
        _bluetoothName = device.bluetoothName;
    }
    return self;
}

- (id)requestArgument {
    
    NSMutableDictionary *arg = [NSMutableDictionary dictionary];
    if (_userID) {
        [arg setObject:_userID forKey:@"boundId"];
    }
    if (_deviceNum) {
        [arg setObject:_deviceNum forKey:@"no"];
    }
    if (_deviceName) {
        [arg setObject:_deviceName forKey:@"name"];
    }
    if (_deviceType) {
        [arg setObject:_deviceType forKey:@"eqType"];
    }
    if (_bluetoothName) {
        [arg setObject:_bluetoothName forKey:@"bluetoothName"];
    }
    
    return arg;
}

- (NSString *)requestUrl {
    return @"Health/app/dsEquipment/iu?";
}

- (NSString *)businessErrorMessage {
    NSString *message;
    switch (self.jyCode) {
        case -1:    message = Localized(@"系统错误");break;
        default:    message = [super businessErrorMessage];break;
    }
    return message;
}

@end
