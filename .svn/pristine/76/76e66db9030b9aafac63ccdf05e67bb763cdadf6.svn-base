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
        
        if (i <= 3 && button.tag != 100) {
            [button setBackgroundImage:PNGIMAGE(@"selected") forState:(UIControlStateSelected)];
            [button setTitleColor:kAppColorAuxiliaryGreen forState:(UIControlStateSelected)];
            
            [button setBackgroundImage:nil forState:(UIControlStateNormal)];
            [button setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
        }
    }
    
    self.nearBtn.selected = YES;
    self.releaseTimeBtn.selected = YES;
    self.doorTimeBtn.selected = NO;
    self.distanceBtn.selected = NO;
    [self.releaseTimeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateSelected)];
    [self.releaseTimeBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
    [self.doorTimeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateSelected)];
    [self.doorTimeBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
    [self.distanceBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateSelected)];
    [self.distanceBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];

    
    self.releaseTimeImgView.image = PNGIMAGE(@"orderlist_down");//orderlist_default
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
