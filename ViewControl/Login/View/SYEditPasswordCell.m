//
//  SYEditPasswordCell.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYEditPasswordCell.h"

@implementation SYEditPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commitBtn.layer.cornerRadius = 3;
    self.commitBtn.layer.masksToBounds = YES;
    
    self.originalPasswordTextFeild.layer.cornerRadius = 3;
    self.originalPasswordTextFeild.layer.masksToBounds = YES;
    
    self.passwordTextFeild.layer.cornerRadius = 3;
    self.passwordTextFeild.layer.masksToBounds = YES;

    self.passwordAgainTextFeild.layer.cornerRadius = 3;
    self.passwordAgainTextFeild.layer.masksToBounds = YES;


    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 50, 36)];
    leftView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:PNGIMAGE(@"password_img")];
    imageView.frame = CGRectMake(15, 5, 20, 25);
    [leftView addSubview:imageView];
 
    self.originalPasswordTextFeild.leftView = leftView;
    self.originalPasswordTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextFeild.leftView = leftView;
//    self.passwordTextFeild.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordAgainTextFeild.leftView = leftView;
//    self.passwordAgainTextFeild.leftViewMode = UITextFieldViewModeAlways;

}

- (IBAction)commitAction:(UIButton *)sender {
    [self.delegate commitPassword:sender originalPassword:self.originalPasswordTextFeild.text newPassword:self.passwordTextFeild.text newPasswordAgain:self.passwordAgainTextFeild.text];
}

@end
