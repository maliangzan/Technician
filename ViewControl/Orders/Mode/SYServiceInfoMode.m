//
//  SYServiceInfoMode.m
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYServiceInfoMode.h"

@implementation SYServiceInfoMode

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"cID" : @"cid",
             @"serviceInfoID" : @"id",
             @"img" : @"img",
             @"isNewRecord" : @"isNewRecord",
             @"name" : @"name",
             @"posture" : @"posture",
             @"price" : @"price",
             @"serviceTotalTime" : @"serviceTotalTime",
             @"SerciceDescription":@"description",

             };
}
@end
