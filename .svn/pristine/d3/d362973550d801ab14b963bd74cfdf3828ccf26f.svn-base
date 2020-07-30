//
//  PaymentToBankView.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentToBankBackView.h"

@implementation PaymentToBankBackView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.layer.masksToBounds = YES;
}

- (IBAction)selectBank:(UIButton *)sender {
    //选择银行
    [self.delegate selectBank];
}

- (IBAction)nextStep:(id)sender {
    [self.delegate nextStep];
}

@end
