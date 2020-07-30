//
//  SYDeviceMode.m
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYDeviceMode.h"

@implementation SYDeviceMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"boundId" : @"boundId",
             @"boundTime" : @"boundTime",
             @"eqType" : @"eqType",
             @"deviceID" : @"id",
             @"isNewRecord" : @"isNewRecord",
             @"deviceName" : @"name",
             @"deviceNum" : @"no",
             @"source" : @"source",
             @"state" : @"state",
             @"connectTime":@"connectTime",
             @"disconnectTime":@"disconnectTime",
             @"bluetoothName":@"bluetoothName"
             
             };
}
@end
