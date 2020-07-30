//
//  SYUploadServiceTimeApi.h
//  Technician
//
//  Created by TianQian on 2017/6/16.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"

@interface SYUploadServiceTimeApi : JYRequestCompressorApi
- (id)initWithServiceTimeString:(NSString *)serviceTimeString;
@end
