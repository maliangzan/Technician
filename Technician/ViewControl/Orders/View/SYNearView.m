//
//  SYNearView.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYNearView.h"

@implementation SYNearView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *button = [self.btnArray objectAtIndex:i];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}
- (void)buttonClickAction:(UIButton *)btn{
    [self.delegate nearViewClickButton:btn];
}
#pragma mark 懒加载
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray arrayWithArray:@[self.nearBtn,self.firstBtn,self.secondBtn,self.thirdBtn,self.moreBtn,self.releaseTimeBtn,self.doorTimeBtn,self.distanceBtn]];
    }
    return _btnArray;
}

@end
