//
//  GetVerificationCodeApi.h
//  Technician
//
//  Created by TianQian on 2017/4/25.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"

@interface GetVerificationCodeApi : JYRequestCompressorApi
- (id)initWithPhoneNum:(NSString *)phoneNUm;

@end
