//
//  SYAppraiseReplyMode.h
//  Technician
//
//  Created by TianQian on 2017/5/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYAppraiseReplyMode : SYMode
@property (nonatomic,strong) NSNumber *aID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,strong) NSNumber *appraiseReplyID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,strong) NSNumber *replyUser;

@end
