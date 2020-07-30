//
//  SYPayInfoMode.h
//  Technician
//
//  Created by TianQian on 2017/5/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYPayInfoMode : SYMode
@property (nonatomic,strong) NSNumber *payInfoID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,strong) NSNumber *payAmount;
@property (nonatomic,copy) NSString *payNo;
@property (nonatomic,copy) NSString *payTime;
@property (nonatomic,strong) NSNumber *soId;
@property (nonatomic,copy) NSString *state;


@end
