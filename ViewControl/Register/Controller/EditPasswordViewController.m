//
//  EditPasswordViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "SYChangePasswordApi.h"

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark superMethod
- (NSString *)nameImageViewImageName{
    return @"password_Img";
}

- (NSString *)codeImageViewImageName{
    return @"password_Img";
}

-(void)buildUI{
    [super buildUI];
    self.navImg.hidden = NO;
    self.backBtn.hidden = NO;
    self.bigBackButton.hidden = NO;
    
    self.titleLabel.text = Localized(@"修改密码");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.nameImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50*kHeightFactor + kCustomNavHeight);
    }];

    self.nameTextField.text = @"";
    self.nameTextField.placeholder = Localized(@"请输入原密码");
    self.PWTextField.placeholder = Localized(@"请输入新密码");
    self.codeTextField.placeholder = Localized(@"请再次输入新密码");
    
    self.nameTextField.keyboardType = UIKeyboardTypeDefault;
    self.PWTextField.keyboardType = UIKeyboardTypeDefault;
    self.codeTextField.keyboardType = UIKeyboardTypeDefault;
    
    self.nameTextField.secureTextEntry = YES;
    self.PWTextField.secureTextEntry = YES;
    self.codeTextField.secureTextEntry = YES;
    [self.submitBtn addTarget:self action:@selector(handleSubmitInAction)  forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setTitle:Localized(@"提交") forState:UIControlStateNormal];

    
    [self.view addSubview:self.codeImg];
    [self.codeImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.pwImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
}


-(void)handleSubmitInAction{

    NSString *oldPwd = self.nameTextField.text;
    NSString *newPwd = self.PWTextField.text;
    NSString *newPwdAgain = self.codeTextField.text;
    
    if (isNull(oldPwd)) {
        [self.view showHUDForError:Localized(@"请输入原密码！")];
        return;
    }
    if (isNull(newPwd)) {
        [self.view showHUDForError:Localized(@"请输入新密码！")];
        return;
    }
    if ([newPwd isEqualToString:oldPwd]) {
        [self.view showHUDForError:Localized(@"新密码不能和原密码相同！")];
        return;
    }
    if (isNull(newPwdAgain)) {
        [self.view showHUDForError:Localized(@"请再次输入新密码！")];
        return;
    }
    
    
    if (![newPwd isEqualToString:newPwdAgain]) {
        [self.view showHUDForError:Localized(@"新密码不一致，请重新输入！")];
        return;
    }
    
    WeakSelf;
    [[[SYChangePasswordApi alloc] initWithLoginName:[SYAppConfig shared].me.loginName newPassword:newPwdAgain oldPassword:oldPwd]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [[UIApplication sharedApplication].keyWindow showHUDForSuccess:Localized(@"密码修改成功！")];
             [SYAppConfig shared].me.password = newPwdAgain;
             [weakself.navigationController popViewControllerAnimated:YES];
             
             NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
             [df setObject:newPwdAgain forKey:passwordKey];
             [df synchronize];
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"未连接到服务器，修改密码失败！")];
     }];
    
}



@end
