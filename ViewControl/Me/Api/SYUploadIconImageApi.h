//
//  SYUploadIconImageApi.h
//  Technician
//
//  Created by TianQian on 2017/6/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "JYRequestCompressorApi.h"

@interface SYUploadIconImageApi : JYRequestCompressorApi
- (id)initWithImageData:(NSData *)imageData;
@end
