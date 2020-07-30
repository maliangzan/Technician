//
//  SYTechnMode.h
//  Technician
//
//  Created by TianQian on 2017/5/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYTechnMode : SYMode
@property (nonatomic,copy) NSString *technAddress;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *dateOfBirth;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,strong) NSNumber *technID;
@property (nonatomic,copy) NSString *idCardNo;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *mobilePhone;
@property (nonatomic,copy) NSString *portrait;
@property (nonatomic,copy) NSString *realName;
//@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,strong) NSNumber *sex;//0男 1女
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *telephone;


@end
