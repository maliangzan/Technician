//
//  SYWithDrawMode.m
//  Technician
//
//  Created by TianQian on 2017/5/16.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYWithDrawMode.h"

@implementation SYWithDrawMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"accountId" : @"accountId",
             @"amount" : @"amount",
             @"approveTime" : @"approveTime",
             @"createTime" : @"createTime",
             @"withDrawID" : @"id",
             @"isNewRecord" : @"isNewRecord",
             @"state" : @"state",
             @"tid" : @"tid",
             @"uid" : @"uid",
             
             };
}
@end
