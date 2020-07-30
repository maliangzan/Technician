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
    
    self.occeptOrderBtn.layer.cornerRadius = 3;
    self.occeptOrderBtn.layer.masksToBounds = YES;
    
    [self.serviceBtn setImage:PNGIMAGE(@"chb_s") forState:(UIControlStateNormal)];
    [self.serviceBtn setImage:PNGIMAGE(@"chb_n") forState:(UIControlStateSelected)];
}
- (IBAction)acceptOrderAction:(UIButton *)sender {
    [self.delegate acceptOrder];
}
- (IBAction)serviceBtnAction:(UIButton *)sender {
    self.serviceBtn.selected = !self.serviceBtn.selected;
}

@end
