//
//  ServiceItemMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface ServiceItemMode : SYMode
@property (nonatomic,copy) NSString *orderID;//订单id
@property (nonatomic,copy) NSString *serviceName;//服务类型名称
@property (nonatomic,copy) NSString *portrait;//图片
@property (nonatomic,copy) NSString *serviceUserName;//服务使用者姓名
@property (nonatomic,copy) NSString *otherRequirement;//备注
@property (nonatomic,copy) NSString *serviceTime;//服务时间
@property (nonatomic,copy) NSString *serviceAddress;//服务地点
@property (nonatomic,copy) NSString *longitude;//经度
@property (nonatomic,copy) NSString *latitude;//纬度
@property (nonatomic,copy) NSString *distance;//距离
@property (nonatomic,copy) NSString *servicePrice;//服务项目价格
@property (nonatomic,copy) NSString *totalTime;//服务时长


@end
