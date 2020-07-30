//
//  WalletStatementCell.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "WalletStatementCell.h"

@implementation WalletStatementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)showDetail:(UIButton *)sender {
    [self.delegate showDetailAtCell:self];
}

@end
