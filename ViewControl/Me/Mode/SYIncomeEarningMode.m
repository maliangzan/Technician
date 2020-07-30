//
//  SYIncomeEarningMode.m
//  Technician
//
//  Created by TianQian on 2017/5/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYIncomeEarningMode.h"

@implementation SYIncomeEarningMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"amount" : @"amount",
             @"createTime" : @"createTime",
             @"earningsID" : @"id",
             @"isNewRecord" : @"isNewRecord",
             @"oID" : @"oid",
             @"order" : @"order",
             @"serviceInfo" : @"serviceInfo",
             @"tid" : @"tid",

             
             
             };
}
@end
