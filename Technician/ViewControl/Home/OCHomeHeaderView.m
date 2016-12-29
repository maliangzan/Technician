//
//  OCHomeHeaderView.m
//  Technician
//
//  Created by 马良赞 on 16/12/29.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "OCHomeHeaderView.h"

@implementation OCHomeHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titlelab];
        [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20*kWidthFactor);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
        self.backgroundView = view;
    }
    return self;
}
-(UILabel *)titlelab{
    if (!_titlelab) {
        _titlelab = [[UILabel alloc]init];
        _titlelab.textColor = [UIColor blackColor];
        _titlelab.textAlignment = NSTextAlignmentLeft;
        _titlelab.font = [UIFont boldSystemFontOfSize:15];
        _titlelab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _titlelab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
