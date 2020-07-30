//
//  SYCustomAlertView.m
//  Technician
//
//  Created by TianQian on 2017/5/23.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYCustomAlertView.h"
#import "NSString+SYStringHelper.h"

#define FONT_OF_SIZE 15
@implementation SYCustomAlertView
{
    NSString *_titleStr;
    NSString *_tipsStr;
    NSString *_cancelStr;
    NSString *_sureStr;
}

- (instancetype)initWithTitle:(NSString *)titleString tips:(NSString *)tipsString cancelTitle:(NSString *)canclString sureTitle:(NSString *)sureTitle{
    if (self = [super init]) {
        _titleStr = titleString;
        _tipsStr = tipsString;
        _cancelStr = canclString;
        _sureStr = sureTitle;
        
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    CGFloat otherViewTotalHeight = isNull(_cancelStr) && isNull(_sureStr) == 1 ? 60 : 100;
    CGFloat viewX = 20;
    CGFloat viewW = KscreenWidth - viewX * 2;
    CGFloat viewH = otherViewTotalHeight + [NSString heightForString:_tipsStr labelWidth:viewW - 40 fontOfSize:FONT_OF_SIZE];
    CGFloat viewY = (KscreenHeight - viewH) / 2;
    
    self.frame = CGRectMake(viewX, viewY, viewW, viewH);
    
    self.backgroundColor = [UIColor whiteColor];
    
    //titlelabel
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = viewW;
    CGFloat titleH = 40;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = kAppColorAuxiliaryGreen;
    titleLable.text = isNull(_titleStr) == YES ? @"":_titleStr;
    [self addSubview:titleLable];
    
    //tipLabel
    CGFloat tipX = 20;
    CGFloat tipY = titleH;
    CGFloat tipW = viewW - 40;
    CGFloat tipH = 20 + [NSString heightForString:_tipsStr labelWidth:viewW - 40 fontOfSize:FONT_OF_SIZE];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipX, tipY, tipW, tipH)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kAppColorTextMiddleBlack;
    tipLabel.text = isNull(_tipsStr) == YES ? @"":_tipsStr;
    tipLabel.font = [UIFont systemFontOfSize:FONT_OF_SIZE];
    tipLabel.numberOfLines = 0;
    [self addSubview:tipLabel];
    
    //lineView
    CGFloat lineX = 0;
    CGFloat lineY = titleH + tipH;
    CGFloat lineW = viewW;
    CGFloat lineH = 1;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    line.backgroundColor = kAppColorBackground;
    [self addSubview:line];
    
    //cancelButton
    CGFloat cancelX = 0;
    CGFloat cancelY = titleH + tipH + lineH;
    CGFloat cancelW = isNull(_sureStr) == YES ? viewW : viewW / 2;
    CGFloat cancelH = viewH - cancelY;
    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    cancelBtn.frame = CGRectMake(cancelX, cancelY, cancelW, cancelH);
    [cancelBtn setTitle:isNull(_cancelStr) == YES ? @"":_cancelStr forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    if (!isNull(_cancelStr)) {
        [self addSubview:cancelBtn];
    }
    
    //sureButton
    CGFloat sureX = isNull(_cancelStr) == YES ? 0:cancelW;
    CGFloat sureY = cancelY;
    CGFloat sureW = isNull(_cancelStr) == YES ? viewW : viewW - cancelW;
    CGFloat sureH = cancelH;
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    sureBtn.frame = CGRectMake(sureX, sureY, sureW, sureH);
    [sureBtn setTitle:isNull(_sureStr) == YES ? @"":_sureStr forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:kAppColorAuxiliaryGreen forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:(UIControlEventTouchUpInside)];
    if (!isNull(_sureStr)) {
        [self addSubview:sureBtn];
    }
    
}

- (void)cancelAction:(UIButton *)btn{
    self.complateBlock(0);
    [self removeFromSuperview];
}

- (void)sureAction:(UIButton *)btn{
    self.complateBlock(1);
    [self removeFromSuperview];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
