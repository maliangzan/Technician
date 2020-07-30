//
//  SYEditUserInfoApi.h
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"
#import "JYUserMode.h"

@interface SYEditUserInfoApi : JYRequestCompressorApi
- (id)initWithUser:(JYUserMode *)user;
@end
