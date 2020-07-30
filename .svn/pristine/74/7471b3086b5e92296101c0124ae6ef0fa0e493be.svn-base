//
//  CommitSuccessTipView.m
//  Technician
//
//  Created by TianQian on 2017/4/11.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "CommitSuccessTipView.h"

@implementation CommitSuccessTipView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.text = Localized(@"资料成功提交！");
    
    NSString *tipStr = Localized(@"我们将在2-3个工作日内审核");
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:tipStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(4, 3)];
    self.labelOne.attributedText = attrStr;
    
    self.labelTwo.text = Localized(@"请耐心等待");
    
    self.labelThree.text = Localized(@"请保持电话畅通");
}

@end
