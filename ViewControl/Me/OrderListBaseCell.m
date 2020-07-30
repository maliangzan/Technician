//
//  OrderListBaseCell.m
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderListBaseCell.h"

@implementation OrderListBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.staduesBtn.layer.cornerRadius = 5;
    self.staduesBtn.layer.masksToBounds = YES;
}
- (IBAction)staduesBtnAction:(UIButton *)sender {
    [self.delegate  clickStaduesBtnAtCell:self];
}

@end
