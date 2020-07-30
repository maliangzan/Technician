//
//  ServiceItemCell.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceItemCell.h"

@implementation ServiceItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = kAppColorBackground.CGColor;
    
    [self.selectedBtn setImage:PNGIMAGE(@"selected0002") forState:(UIControlStateSelected)];
    [self.selectedBtn setImage:nil forState:(UIControlStateNormal)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
