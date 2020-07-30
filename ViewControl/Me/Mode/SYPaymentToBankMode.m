//
//  SYPaymentToBankMode.m
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYPaymentToBankMode.h"

@implementation SYPaymentToBankMode
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"bankName" : @"bankName",
             @"cardtype" : @"cardtype",
             @"encoding" : @"encoding",
             @"bankID" : @"bankId",
             @"isNewRecord" : @"isNewRecord",
             @"accountName":@"accountName",
             @"accountNo":@"accountNo",
             @"amount":@"amount",
             @"createTime":@"createTime",
             @"nextStepID":@"id",
             @"tid":@"tid",
             @"accountType":@"accountType",

             };
}
@end
