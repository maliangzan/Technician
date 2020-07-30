//
//  MyEvaluateCell.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "MyEvaluateCell.h"

@implementation MyEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

@end
