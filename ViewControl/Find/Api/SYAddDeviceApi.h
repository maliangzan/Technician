//
//  SYAddDeviceApi.h
//  Technician
//
//  Created by TianQian on 2017/6/28.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"
#import "SYDeviceMode.h"

@interface SYAddDeviceApi : JYRequestCompressorApi
@property (nonatomic,strong) SYDeviceMode *deviceMode;

- (id)initWithDeviceMode:(SYDeviceMode *)device;

@end
