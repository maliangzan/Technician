//
//  SYLocationMode.m
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYLocationMode.h"

@implementation SYLocationMode

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"sAddress" : @"address",
             @"sLocationID" : @"id",
             @"isNewRecord" : @"isNewRecord",
             @"latitude" : @"latitude",
             @"longitude" : @"longitude",
             @"oID" : @"oid",
             
             };
}
@end
