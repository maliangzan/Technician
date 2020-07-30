//
//  SYPaymentToBankMode.h
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYMode.h"

@interface SYPaymentToBankMode : SYMode
@property (nonatomic,copy) NSString *bankName;//银行名称
@property (nonatomic,copy) NSString *cardtype;//银行卡类型 debit—借记卡 credit—信用卡
@property (nonatomic,copy) NSString *encoding;//银行字符编码
@property (nonatomic,strong) NSNumber *bankID;
@property (nonatomic,assign) BOOL isNewRecord;
@property (nonatomic,copy) NSString *accountName;//账户名
@property (nonatomic,copy) NSString *accountNo;//银行卡号,账户
@property (nonatomic,strong) NSNumber *amount;//提现金额
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,strong) NSNumber *nextStepID;
@property (nonatomic,copy) NSString *state;//init 初始 pass 审批通过，success 成功，failure 失败，unknown 未知
@property (nonatomic,strong) NSNumber *tid;
@property (nonatomic,copy) NSString *accountType;


@end
