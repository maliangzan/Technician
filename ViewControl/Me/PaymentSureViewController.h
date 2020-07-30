//
//  PaymentSureViewController.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "BaseNavigationController.h"
#import "SYPaymentToBankMode.h"

@interface PaymentSureViewController : BaseNavigationController
- (instancetype)initWithPaymentToBankMode:(SYPaymentToBankMode *)mode;

@end
