//
//  FeedbackRecordCell.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "FeedbackRecordCell.h"

@implementation FeedbackRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)feedBackDetailAction:(UIButton *)sender {
    [self.delegate showFeedBackDetailAtCell:self];
}

@end
