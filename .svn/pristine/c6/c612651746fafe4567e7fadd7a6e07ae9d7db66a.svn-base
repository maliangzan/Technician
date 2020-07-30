//
//  ForgetViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "ForgetViewController.h"
#import "SYForgetPasswordApi.h"
#import "ResetPasswordViewController.h"

@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark superMethod

-(void)buildUI{
    [super buildUI];
    self.navImg.hidden = NO;
    self.backBtn.hidden = NO;
    self.bigBackButton.hidden = NO;
    
    self.titleLabel.text = Localized(@"取回密码");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.nameImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50*kHeightFactor + kCustomNavHeight);
    }];

    self.nameTextField.placeholder = Localized(@"请输入手机号");
//    self.nameTextField.text = [SYAppConfig shared].me.loginName;
    self.nameTextField.text = @"";
    self.PWTextField.placeholder = Localized(@"请输入身份证账号码");
    self.codeTextField.placeholder = Localized(@"输入验证码");
    [self.submitBtn addTarget:self action:@selector(handleSubmitInAction)  forControlEvents:UIControlEventTouchUpInside];
    self.title = Localized(@"取回密码");
    [self.submitBtn setTitle:Localized(@"确认") forState:UIControlStateNormal];
    self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    //如果需要身份证号码，删除如下代码***********//
    self.pwImg.hidden = YES;
    self.PWTextField.hidden = YES;
    [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-100*kWidthFactor);
        make.top.equalTo(self.nameImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeImg.mas_right).offset(0);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.nameImg.mas_bottom).offset(16*kHeightFactor);
        make.height.equalTo(self.codeImg);
    }];
    //****************************************//
    
}
-(void)handleSubmitInAction{
    [self.view endEditing:YES];
    if (![self.nameTextField.text isValidPhone]) {
        [self.view showHUDForError:Localized(@"请输入正确的手机号")];
        return;
    }
    
    //暂时不需要身份证号
//    if (!IsIdentityCard(self.PWTextField.text)) {
//        [self.view showHUDForError:Localized(@"请输入正确的身份证号")];
//        return;
//    }
    
    NSString *code = self.codeTextField.text;
    if (isNull(code)) {
        [self.view showHUDForError:Localized(@"请输入验证码！")];
        return;
    }

    NSString *inputCode = self.codeTextField.text;
    if (![inputCode isEqualToString:self.code]) {
        [self.view showHUDForError:Localized(@"验证码错误，请重新输入！")];
        return;
    }
    
    WeakSelf;
    [[[SYForgetPasswordApi alloc] initWithLoginName:self.nameTextField.text idCardNum:@"" verificationCode:self.codeTextField.text]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [SYAppConfig shared].me.loginName = self.nameTextField.text;
             
             ResetPasswordViewController *resetVC = [[ResetPasswordViewController alloc] init];
             [self.navigationController pushViewController:resetVC animated:YES];
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"未连接到服务器，身份验证失败！")];
     }];
    
}

@end
