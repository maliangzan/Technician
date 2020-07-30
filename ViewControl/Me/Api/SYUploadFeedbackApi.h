//
//  SYUploadFeedbackApi.h
//  Technician
//
//  Created by TianQian on 2017/6/19.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"

@interface SYUploadFeedbackApi : JYRequestCompressorApi
- (id)initWithFeedBackString:(NSString *)feedBackString;
@end
