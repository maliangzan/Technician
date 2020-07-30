//
//  SYTheNewOrderCell.m
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYTheNewOrderCell.h"

@interface SYTheNewOrderCell ()

@end
@implementation SYTheNewOrderCell

- (void)buildUI{
    [super buildUI];
    self.nameLabel.hidden = YES;
    self.sexBtn.hidden = YES;
    self.sourceOfOrderBtn.hidden = YES;
    
    [self.remarkLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-8*kWidthFactor);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12*kWidthFactor);
        
    }];
    
    [self.serviceTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(8*kWidthFactor);
    }];

    
}


@end
