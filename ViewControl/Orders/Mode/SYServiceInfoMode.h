//
//  SYServiceInfoMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYServiceInfoMode : SYMode
@property (nonatomic,strong) NSNumber *cID;
@property (nonatomic,strong) NSNumber *serviceInfoID;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *posture;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) NSNumber *serviceTotalTime;
@property (nonatomic,copy) NSString *SerciceDescription;



@end
