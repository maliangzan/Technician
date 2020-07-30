
//
//  ServiceTimeBackView.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceTimeBackView.h"

@implementation ServiceTimeBackView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.overBtn.layer.cornerRadius = 3;
    self.overBtn.layer.masksToBounds = YES;
}

- (IBAction)overBtnAction:(UIButton *)sender {
    [self.delegate overTheTime];
}

@end
