//
//  SYPaymentSureApi.h
//  Technician
//
//  Created by TianQian on 2017/5/31.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"
#import "SYPaymentToBankMode.h"

@interface SYPaymentSureApi : JYRequestCompressorApi
- (id)initWithPaymentToBankMode:(SYPaymentToBankMode *)mode password:(NSString *)pwd;
@end
