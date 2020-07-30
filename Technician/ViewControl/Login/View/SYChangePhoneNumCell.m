//
//  SYChangePhoneNumCell.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYChangePhoneNumCell.h"

@implementation SYChangePhoneNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commitBtn.layer.cornerRadius = 3;
    self.commitBtn.layer.masksToBounds = YES;
    
    self.phoneNumTextFeild.layer.cornerRadius = 3;
    self.phoneNumTextFeild.layer.masksToBounds = YES;
    
    self.verificationCodeTextFeild.layer.cornerRadius = 3;
    self.verificationCodeTextFeild.layer.masksToBounds = YES;
    
    //
    //code_phone
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 50, 36)];
    leftView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:PNGIMAGE(@"img_mobilePhone")];
    imageView.frame = CGRectMake(15, 5, 20, 25);
    [leftView addSubview:imageView];
    
    self.phoneNumTextFeild.leftView = leftView;
    self.phoneNumTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
//    self.verificationCodeTextFeild.leftView = leftView;
//    self.verificationCodeTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
}

- (IBAction)verificationCodeAction:(UIButton *)sender {
    [self.delegate gettingErificationCode];
}

- (IBAction)commitAction:(UIButton *)sender {
    [self.delegate commitNewPhoneNum:self.phoneNumTextFeild.text];
}

@end
