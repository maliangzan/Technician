//
//  SYAppraiseDetailMode.h
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYAppraiseMode : SYMode
@property (nonatomic,strong) NSNumber *attitudeGood;
@property (nonatomic,strong) NSNumber *attitudeStarCount;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,strong) NSNumber *createUser;
@property (nonatomic,strong) NSNumber *effectGood;
@property (nonatomic,strong) NSNumber *goodLooking;
@property (nonatomic,strong) NSNumber *appraiseID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,strong) NSNumber *manipulationProfession;
@property (nonatomic,strong) NSNumber *muiltpraise;
@property (nonatomic,strong) NSNumber *patience;
@property (nonatomic,strong) NSNumber *politeness;
@property (nonatomic,strong) NSNumber *praiseCount;
@property (nonatomic,strong) NSNumber *professionStarCount;
@property (nonatomic,strong) NSNumber *soId;
@property (nonatomic,strong) NSDictionary *appraiseReplyDic;


@end
