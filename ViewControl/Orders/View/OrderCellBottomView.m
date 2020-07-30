//
//  OrderCellBottomView.m
//  Technician
//
//  Created by TianQian on 2017/5/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderCellBottomView.h"

@implementation OrderCellBottomView
- (IBAction)orderAction:(UIButton *)sender {
    [self.delegate order];
}

@end
