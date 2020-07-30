//
//  ServiceAddressCell.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceAddressCell.h"

@implementation ServiceAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)contactUserAction:(UIButton *)sender {
    [self.delegate contactUserAtCell:self];
}

- (IBAction)locationAction:(UIButton *)sender {
    [self.delegate locationTheAddressAtCell:self];
}

@end
