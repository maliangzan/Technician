//
//  ResetPasswordViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordApi.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSString *)nameImageViewImageName{
    return @"password_Img";
}

-(void)buildUI{
    [super buildUI];
    self.navImg.hidden = NO;
    self.backBtn.hidden = NO;
    self.bigBackButton.hidden = NO;
    
    self.titleLabel.text = Localized(@"重置密码");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.nameTextField.secureTextEntry = YES;
    self.PWTextField.secureTextEntry = YES;
    [self.nameImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50*kHeightFactor + kCustomNavHeight);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.pwImg.mas_bottom).offset(42*kHeightFactor);
        make.height.mas_offset(39*kHeightFactor);
    }];
    
    self.nameTextField.placeholder = Localized(@"输入新密码");
    self.nameTextField.text = @"";
    self.PWTextField.placeholder = Localized(@"再次输入新密码");
    self.codeImg.hidden = YES;
    self.codeBtn.hidden = YES;
    [self.submitBtn addTarget:self action:@selector(handleSubmitInAction)  forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitBtn setTitle:Localized(@"确定修改") forState:UIControlStateNormal];
    self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
}
-(void)handleSubmitInAction{
    NSString *newPwd = self.nameTextField.text;
    NSString *newPwdAgain = self.PWTextField.text;
    if (isNull(newPwd)) {
        [self.view showHUDForError:Localized(@"请输入新密码")];
        return;
    }
    
    if (isNull(newPwdAgain)) {
        [self.view showHUDForError:Localized(@"请再次输入新密码")];
        return;
    }
    if (![newPwd isEqualToString:newPwdAgain]) {
        [self.view showHUDForError:Localized(@"输入的密码不一致，请检查！")];
        return;
    }
    
    WeakSelf;
    [[[ResetPasswordApi alloc] initWithLoginName:[SYAppConfig shared].me.loginName newPassword:newPwdAgain]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [weakself.view showHUDForSuccess:Localized(@"密码重置成功")];
             [SYAppConfig shared].me.password = newPwdAgain;
             [[SYAppConfig shared] loginWithAccount:[SYAppConfig shared].me.loginName password:newPwdAgain];
             
             NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
             [df setObject:newPwdAgain forKey:passwordKey];
             [df synchronize];
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"未连接到服务器，密码重置失败！")];
     }];
    
}

@end
