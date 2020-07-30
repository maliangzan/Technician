//
//  PaymentSureBackView.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentSureBackView.h"

@implementation PaymentSureBackView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.sureBtn.layer.cornerRadius = 3;
    self.sureBtn.layer.masksToBounds = YES;
}

- (IBAction)sureActin:(UIButton *)sender {
    [self.delegate surePaymentToBank];
}

@end
