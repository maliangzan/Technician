//
//  SYShowListView.m
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYShowListView.h"

@implementation SYShowListView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
    [self addGestureRecognizer:tap];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
    [self.delegate clikEmptyAndRemoveSubView];
}

#pragma mark get


@end
