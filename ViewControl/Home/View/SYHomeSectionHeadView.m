//
//  SYHomeSectionHeadView.m
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYHomeSectionHeadView.h"

@implementation SYHomeSectionHeadView

- (IBAction)moreAction:(UIButton *)sender {
    [self.delegate loockMoreAt:self];
}

@end
