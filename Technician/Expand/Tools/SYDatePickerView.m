//
//  JSDatePickerView.m
//  Printer
//
//  Created by 王俊杰 on 15/9/23.
//  Copyright (c) 2015年 爱聚印. All rights reserved.
//

#import "SYDatePickerView.h"

@interface SYDatePickerView ()

@property (nonatomic, strong) UIControl *control;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SYDatePickerView
{
    __weak IBOutlet NSLayoutConstraint *_lyTopLineHeight;
    __weak IBOutlet NSLayoutConstraint *_lyMidLineWidth;
    __weak IBOutlet NSLayoutConstraint *_lyBottomLineHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    /**国际化 Tina*/
    [self internationalInit];

    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [[UIColor hexColor:0xdcdcdc] CGColor];
    self.layer.borderWidth = 0.5;
    _control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _control.backgroundColor = [UIColor hexColor:0x000000 alpha:0.6];
    [_control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _lyBottomLineHeight.constant =
    _lyMidLineWidth.constant =
    _lyTopLineHeight.constant = 0.5;
    
}

- (void)internationalInit {
    self.titleLabel.text = Localized(@"预计到达时间");
    [self.cancelBtn setTitle:Localized(@"取消") forState:(UIControlStateNormal)];
    [self.sureBtn setTitle:Localized(@"确定") forState:(UIControlStateNormal)];
}

- (IBAction)cancelAction:(id)sender {
    [self dismiss];
}

- (IBAction)sureAction:(id)sender {
    if (self.datePicked) {
        self.datePicked(self.datePicker.date);
    }
    [self dismiss];
}



- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.control];
    [window addSubview:self];
    self.frame = CGRectMake(0, 0, KscreenWidth - 40, 257);
    self.center = window.center;
}

- (void)dismiss {
    [self.control removeFromSuperview];
    [self removeFromSuperview];
}

@end
