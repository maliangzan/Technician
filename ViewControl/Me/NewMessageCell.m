//
//  NewMessageCell.m
//  Technician
//
//  Created by TianQian on 2017/4/7.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
}


@end
