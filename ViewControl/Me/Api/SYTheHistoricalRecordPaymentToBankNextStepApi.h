//
//  SYTheHistoricalRecordPaymentToBankNextStepApi.h
//  Technician
//
//  Created by TianQian on 2017/6/1.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"
#import "SYAccountMode.h"

@interface SYTheHistoricalRecordPaymentToBankNextStepApi : JYRequestCompressorApi
- (id)initWithAccountMode:(SYAccountMode *)mode;
@end
