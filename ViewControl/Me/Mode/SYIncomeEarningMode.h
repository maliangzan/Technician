//
//  SYIncomeEarningMode.h
//  Technician
//
//  Created by TianQian on 2017/5/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYIncomeEarningMode : SYMode
@property (nonatomic,strong) NSNumber *amount;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,strong) NSNumber *earningsID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,strong) NSNumber *oID;
@property (nonatomic,strong) NSDictionary *order;
@property (nonatomic,strong) NSDictionary *serviceInfo;
@property (nonatomic,strong) NSNumber *tid;
@end
