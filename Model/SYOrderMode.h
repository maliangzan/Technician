//
//  SYOrderMode.h
//  Technician
//
//  Created by TianQian on 2017/5/3.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYOrderMode : SYMode
@property (nonatomic,copy) NSString *actServiceEndTime;
@property (nonatomic,copy) NSString *actServiceStartTime;
@property (nonatomic,copy) NSString *appointServiceTime;
//@property (nonatomic,strong) NSNumber *scrambleTime;
@property (nonatomic,copy) NSString *scrambleTime;

//@property (nonatomic,strong) NSNumber *cID;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,strong) NSNumber *orderID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *otherRequirement;
//@property (nonatomic,strong) NSNumber *referrer;
//@property (nonatomic,copy) NSString *referrerType;
//@property (nonatomic,strong) NSNumber *sID;
@property (nonatomic,copy) NSString *soNo;
@property (nonatomic,copy) NSString *state;
//@property (nonatomic,strong) NSNumber *tID;
@property (nonatomic,strong) NSNumber *tradePrice;//订单金额
@property (nonatomic,copy) NSString *tradeTime;
@property (nonatomic,copy) NSString *transactionId;
@property (nonatomic,copy) NSString *type;//qd—抢单；xtpd—系统派单；khpd—客户派单；
@property (nonatomic,assign) BOOL isAppraise;//是否评论

//@property (nonatomic,strong) NSNumber *uID;

@end
