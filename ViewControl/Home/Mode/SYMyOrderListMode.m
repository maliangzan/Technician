//
//  SYMyOrderListMode.m
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMyOrderListMode.h"

@implementation SYMyOrderListMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"order" : @"order",
             @"serviceInfo" : @"serviceInfo",
             @"sLocation" : @"sLocation",
             @"user" : @"user",

             };
}
@end
