//
//  SYNearbyOrderMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"
#import "SYCustomMode.h"
#import "SYOrderMode.h"
#import "SYLocationMode.h"
#import "SYServiceInfoMode.h"
#import "JYUserMode.h"
#import "SYPayInfoMode.h"
#import "SYTechnMode.h"

@interface SYNearbyOrderMode : SYMode

//@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,strong) NSNumber *distance;
@property (nonatomic,strong) NSNumber *realServiceTime;//实际服务时长
@property (nonatomic,strong) NSDictionary *order;
@property (nonatomic,strong) NSDictionary *serviceInfo;
@property (nonatomic,strong) NSDictionary *customer;
@property (nonatomic,strong) NSDictionary *sLocation;
@property (nonatomic,strong) NSDictionary *user;
@property (nonatomic,strong) NSDictionary *payInfo;
@property (nonatomic,strong) NSDictionary *techn;
//@property (nonatomic,copy) NSString *appraise;
@property (nonatomic,copy) NSString *devUser;
@property (nonatomic,copy) NSString *dsSkill;
@property (nonatomic,copy) NSString *technicianAge;
@property (nonatomic,copy) NSString *technicianAppraiseTimes;
@property (nonatomic,copy) NSString *technicianServiceTimes;
@property (nonatomic,copy) NSString *userInfoBaby;
@property (nonatomic,copy) NSString *userphoto;
@property (nonatomic,strong) NSNumber *timeCount;//订单发布时间（单位：S）

@end
