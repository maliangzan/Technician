//
//  ResetPasswordApi.h
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"

@interface ResetPasswordApi : JYRequestCompressorApi
- (id)initWithLoginName:(NSString *)loginName newPassword:(NSString *)newPwd;

@end
