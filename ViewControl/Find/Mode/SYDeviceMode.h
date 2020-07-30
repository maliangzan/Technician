//
//  SYDeviceMode.h
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYDeviceMode : SYMode
@property (nonatomic,strong) NSNumber *boundId;
@property (nonatomic,copy) NSString *boundTime;
@property (nonatomic,copy) NSString *eqType;
@property (nonatomic,strong) NSNumber *deviceID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *deviceName;//设备名称
@property (nonatomic,copy) NSString *deviceNum;//设备编码 PM0820170104
@property (nonatomic,copy) NSString *bluetoothName;//即蓝牙名称
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *state;

@property (nonatomic,copy) NSString *deviceImageName;
@property (nonatomic,assign) BOOL isInTheUse;//是否使用中
@property (nonatomic,copy) NSString *connectTime;//设备连接时间
@property (nonatomic,copy) NSString *disconnectTime;//设备断开时间



@end
