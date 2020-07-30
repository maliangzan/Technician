//
//  UserSexCell.m
//  Technician
//
//  Created by TianQian on 2017/4/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "UserSexCell.h"

@implementation UserSexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.manBtn setImage:PNGIMAGE(@"select") forState:(UIControlStateSelected)];
    [self.manBtn setImage:PNGIMAGE(@"unselect") forState:(UIControlStateNormal)];
    [self.womanBtn setImage:PNGIMAGE(@"select") forState:(UIControlStateSelected)];
    [self.womanBtn setImage:PNGIMAGE(@"unselect") forState:(UIControlStateNormal)];
}

- (IBAction)selectManAction:(UIButton *)sender {
    self.manBtn.selected = YES;
    self.womanBtn.selected = NO;
    [self.delegate selectSex:YES];
}

- (IBAction)selectWomanAction:(UIButton *)sender {
    self.manBtn.selected = NO;
    self.womanBtn.selected = YES;
    [self.delegate selectSex:NO];
}

@end
