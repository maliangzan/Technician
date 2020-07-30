//
//  SYLocationMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYLocationMode : SYMode
@property (nonatomic,copy) NSString *sAddress;
@property (nonatomic,strong) NSNumber *sLocationID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@property (nonatomic,strong) NSNumber *oID;


@end
