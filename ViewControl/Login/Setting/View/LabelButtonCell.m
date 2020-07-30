//
//  LabelButtonCell.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "LabelButtonCell.h"

@implementation LabelButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:autoLocationStateKey];

    [self.rightBtn setImage:PNGIMAGE(@"chb_n") forState:(UIControlStateNormal)];
    [self.rightBtn setImage:PNGIMAGE(@"chb_s") forState:(UIControlStateSelected)];
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    [self.delegate rightBtnClickAtCell:self clickButton:sender];
}

@end
