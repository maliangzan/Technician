//
//  BaseForgetVC.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BaseForgetRegisterVC.h"

@interface BaseForgetRegisterVC ()

@end

@implementation BaseForgetRegisterVC

@synthesize nameImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setBackgroundImage:PNGIMAGE(@"login_Bt_Img") forState:UIControlStateNormal];
    }
    return _submitBtn;
}
-(JKCountDownButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [[JKCountDownButton alloc]init];
        [_codeBtn setBackgroundColor:[UIColor whiteColor]];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_codeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _codeBtn;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)buildUI{
    [super buildUI];
    self.nameTextField = [self textFieldWithPlaceHolder:nil];
    self.PWTextField = [self textFieldWithPlaceHolder:nil];
    self.codeTextField = [self textFieldWithPlaceHolder:nil];
    self.PWTextField.secureTextEntry = YES;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    nameImg = [self createInputViewReferTo:self.nameTextField IconImgStr:@"user_name_Img"];
    UIImageView *pwImg = [self createInputViewReferTo:self.PWTextField IconImgStr:@"password_Img"];
    UIImageView *codeImg = [self createInputViewReferTo:self.codeTextField IconImgStr:@"verification_Code"];
    
    [self.view addSubview:nameImg];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.view).offset(101*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:pwImg];
    [pwImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(nameImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-100*kWidthFactor);
        make.top.equalTo(pwImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeImg.mas_right).offset(0);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(pwImg.mas_bottom).offset(16*kHeightFactor);
        make.height.equalTo(codeImg);
    }];
    
    //验证码按钮
    [self.codeBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startCountDownWithSecond:60];
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(codeImg.mas_bottom).offset(42*kHeightFactor);
        make.height.mas_offset(39*kHeightFactor);
    }];
}

@end
