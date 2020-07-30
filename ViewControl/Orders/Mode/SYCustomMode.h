//
//  SYCustomMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYCustomMode : SYMode
@property (nonatomic,copy) NSString *omilAddress;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *dateOfBirth;
@property (nonatomic,copy) NSString *email;
//@property (nonatomic,assign) NSInteger cusID;
@property (nonatomic,copy) NSString *cusCardNum;
//@property (nonatomic,strong) NSNumber *isNewRecord;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *loginName;
@property (nonatomic,copy) NSString *mobilePhone;
@property (nonatomic,copy) NSString *portrait;
@property (nonatomic,copy) NSString *realName;
//@property (nonatomic,assign) NSInteger referrer;
@property (nonatomic,copy) NSString *referrerIsTech;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *telePhone;


@end
