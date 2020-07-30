//
//  OrdersBtnCell.m
//  Technician
//
//  Created by 马良赞 on 17/1/5.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrdersBtnCell.h"

@implementation OrdersBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.serviceBtn.selected = YES;
    [self.serviceBtn setImage:PNGIMAGE(@"chb_s") forState:(UIControlStateSelected)];
    [self.serviceBtn setImage:PNGIMAGE(@"chb_n") forState:(UIControlStateNormal)];
    
    self.tipsLabel.text = Localized(@"接单马上赠送50万人身保险");
}
- (IBAction)acceptOrderAction:(UIButton *)sender {
    [self.delegate acceptOrder];
}
- (IBAction)serviceBtnAction:(UIButton *)sender {
    self.serviceBtn.selected = !self.serviceBtn.selected;
    [self.delegate agreeToTheServiceAgreeMent:self.serviceBtn.selected];
}

@end
