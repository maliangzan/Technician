//
//  RegisterViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "RegisterViewController.h"
#import "SYRegisterApi.h"
#import "SYAppConfig.h"
#import "UserAgreementViewController.h"

@interface RegisterViewController ()
@property (nonatomic,strong) UIButton *userAgreementBtn;
@property (nonatomic,strong) UIButton *lookUserAgreementBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)buildUI{
    [super buildUI];
    
    [self.view addSubview:self.userAgreementBtn];
    [self.userAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.submitBtn);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(10*kHeightFactor);
    }];
    
    [self.view addSubview:self.lookUserAgreementBtn];
    [self.lookUserAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userAgreementBtn.mas_right);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(10*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(100, 20*kHeightFactor));
    }];
    
    self.nameTextField.placeholder = @"输入手机号";
    self.nameTextField.text = @"";
    self.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    self.PWTextField.placeholder = @"输入密码";
    self.PWTextField.secureTextEntry = YES;
    self.codeTextField.placeholder = @"输入验证码";
    
    [self.actionBtn setTitle:@"账号登录>>" forState:UIControlStateNormal];
    [self.actionBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateNormal)];
    [self.actionBtn addTarget:self action:@selector(handleBackInAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)handleBackInAction{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerNewAccountWithPhoneNum:(NSString *)phone password:(NSString *)password codeTextFeild:(UITextField *)codeTextFeild{
    
    if (![phone isValidPhone]) {
        [self.view showHUDForError:@"输入正确的手机号"];
        return;
    }
    
    if (isNull(password)) {
        [self.view showHUDForError:Localized(@"密码不能为空！")];
        return;
    }
    
    NSString *code = self.codeTextField.text;
    if (isNull(code)) {
        [self.view showHUDForError:Localized(@"请输入验证码！")];
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:isAgreeUserAgreement]) {
        [self.view showHUDForError:Localized(@"请阅读并同意技师端《用户服务协议》")];
        return;
    }

    NSString *inputCode = codeTextFeild.text;
    if (![inputCode isEqualToString:self.code]) {
        [self.view showHUDForError:Localized(@"验证码错误，请重新输入！")];
        return;
    }
    
    WeakSelf;
    [[[SYRegisterApi alloc] initWithLoginName:phone password:password verificationCode:codeTextFeild.text]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [SYAppConfig shared].me.hasJoinIn = NO;
             [weakself.navigationController popToRootViewControllerAnimated:NO];
             [[SYAppConfig shared] loginWithAccount:phone password:password];
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
     }];
}

#pragma mark method
- (void)userAgreementBtnAction{
    self.userAgreementBtn.selected = !self.userAgreementBtn.selected;
    [[NSUserDefaults standardUserDefaults] setBool:self.userAgreementBtn.selected forKey:isAgreeUserAgreement];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)lookUserAgreementBtnAction{
    UserAgreementViewController *vc = [[UserAgreementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark get
- (UIButton *)userAgreementBtn{
    if (!_userAgreementBtn) {
        _userAgreementBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _userAgreementBtn.selected = YES;
        [_userAgreementBtn setImage:PNGIMAGE(@"chb_s") forState:(UIControlStateSelected)];
        [_userAgreementBtn setImage:PNGIMAGE(@"chb_n") forState:(UIControlStateNormal)];
        NSAttributedString *attString = [NSString joiningTogetherSting:@"我已阅读并接受技师端" withAStringColor:kAppColorTextMiddleBlack andBString:@"《用户服务协议》" withBStringColor:kAppColorAuxiliaryGreen];
        [_userAgreementBtn setAttributedTitle:attString forState:(UIControlStateNormal)];
        [_userAgreementBtn setTitleColor:kAppColorTextMiddleBlack forState:(UIControlStateNormal)];
        _userAgreementBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_userAgreementBtn addTarget:self action:@selector(userAgreementBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _userAgreementBtn;
}

- (UIButton *)lookUserAgreementBtn{
    if (!_lookUserAgreementBtn) {
        _lookUserAgreementBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_lookUserAgreementBtn addTarget:self action:@selector(lookUserAgreementBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lookUserAgreementBtn;
}

@end
