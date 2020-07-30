//
//  AllEvaluateCell.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "AllEvaluateCell.h"

@implementation AllEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)thumbUp:(UIButton *)sender {
    [self.delegate thumbUpAtCell:self];
}

@end
