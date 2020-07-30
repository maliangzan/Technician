//
//  SYNearbyServiceMode.m
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYNearbyServiceMode.h"

@implementation SYNearbyServiceMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"serviceID" : @"id",
             @"isNewRecord" : @"isNewRecord",
             @"name" : @"name",

             };
}
@end
