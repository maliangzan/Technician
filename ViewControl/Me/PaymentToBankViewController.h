//
//  PaymentToBankViewController.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"
#import "SYAccountMode.h"

typedef NS_ENUM(NSInteger,SYInComeType) {
    SYInComeTypeTheCommonlyUsed = 0,//常用提现方式
    SYInComeTypeTheHistoricalRecord = 1,//历史记录
    
};

@interface PaymentToBankViewController : BaseNavigationController

- (instancetype)initWithIncomeType:(SYInComeType)type accountMode:(SYAccountMode *)accountMode;

@end
