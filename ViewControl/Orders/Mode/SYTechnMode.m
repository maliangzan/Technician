//
//  SYTechnMode.m
//  Technician
//
//  Created by TianQian on 2017/5/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYTechnMode.h"

@implementation SYTechnMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"technAddress" : @"address",
             @"createTime" : @"createTime",
             @"dateOfBirth" : @"dateOfBirth",
             @"email" : @"email",
             @"technID" : @"id",
             @"idCardNo" : @"idCardNo",
             @"isNewRecord" : @"isNewRecord",
             @"level" : @"level",
             @"mobilePhone" : @"mobilephone",
             @"portrait" : @"portrait",
             @"realName" : @"realName",
             @"sex" : @"sex",
             @"state" : @"state",
             @"telephone" : @"telephone",

             
             };
}
@end
