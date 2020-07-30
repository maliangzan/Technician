//
//  LoginViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/21.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"

@interface LoginViewController ()
@property (nonatomic , strong) UIImageView *logoImg;
@property (nonatomic , strong) UITextField *nameTextField;
@property (nonatomic , strong) UITextField *PWTextField;
@property (nonatomic , strong) UIButton *loginBT;
@property (nonatomic , strong) UIButton *forgetPwBT;
@property (nonatomic , strong) UIButton *rememberThePasswordBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self registerNotificationCenter];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isOnTheLoginViewController];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isOnTheLoginViewController];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dealloc{
    [self unRegisterNotificationCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)buildUI{
    [super buildUI];
    
    [self.view addSubview:self.logoImg];
    
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(62*kHeightFactor);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(87.5*kWidthFactor, 101*kHeightFactor));
    }];
    
    self.nameTextField = [self textFieldWithPlaceHolder:@"输入手机号"];
    self.PWTextField = [self textFieldWithPlaceHolder:@"输入密码"];
    self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.PWTextField.secureTextEntry = YES;
    UIImageView *nameImg = [self createInputViewReferTo:self.nameTextField IconImgStr:@"user_name_Img"];
    UIImageView *pwImg = [self createInputViewReferTo:self.PWTextField IconImgStr:@"password_Img"];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *account = [df objectForKey:accountKey];
    NSString *password = [df objectForKey:passwordKey];
    self.nameTextField.text = account;
    self.PWTextField.text = password;
    
    [self.view addSubview:nameImg];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.logoImg.mas_bottom).offset(46*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:pwImg];
    [pwImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(nameImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:self.loginBT];
    [self.loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(pwImg.mas_bottom).offset(43*kHeightFactor);
        make.height.mas_offset(39*kHeightFactor);
    }];
    
    [self.view addSubview:self.forgetPwBT];
    [self.forgetPwBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.top.equalTo(self.loginBT.mas_bottom).offset(10*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(100*kWidthFactor, 20*kHeightFactor));
    }];
    
    [self.view addSubview:self.rememberThePasswordBtn];
    [self.rememberThePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(20*kWidthFactor);
        make.top.equalTo(self.loginBT.mas_bottom).offset(10*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(100*kWidthFactor, 20*kHeightFactor));
    }];
    
    
    
    [self.actionBtn setTitle:@"没有账号>>" forState:UIControlStateNormal];
    [self.actionBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:UIControlStateNormal];
    
    [self.loginBT addTarget:self action:@selector(handleSignInAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPwBT addTarget:self action:@selector(handleForgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.actionBtn addTarget:self action:@selector(handleRegisterAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)handleSignInAction{
    //测试用，直接登录,避免等待或登录失败
    //    [[SYAppConfig shared] dissMissLoginControllerAndBackToHome];
    //    return;
    [self.view endEditing:YES];
    if (![self.nameTextField.text isValidPhone]) {
        [self.view showHUDForError:Localized(@"输入正确的手机号")];
        return;
    }
    
    [self loginWithAccount:self.nameTextField.text password:self.PWTextField.text];
    
}

- (void)registerNotificationCenter{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)unRegisterNotificationCenter{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [defaultCenter removeObserver:self];
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password{
    [[SYAppConfig shared] loginWithAccount:account password:password];
}

//忘记密码
-(void)handleForgetAction{
    ForgetViewController *forgetVC = [[ForgetViewController alloc]init];
    forgetVC.actionBtn.hidden = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
}


-(void)handleRegisterAction{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [registerVC.submitBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark -
#pragma keyboard show and hidden
//隐藏键盘触发
- (void) keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:kAnimationTime animations:^{
        [self.logoImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(62*kHeightFactor);
        }];
    } completion:^(BOOL finished) {
        
    }];
}
- (void) keyboardWillShow:(NSNotification *)notification{
    [UIView animateWithDuration:kAnimationTime animations:^{
        [self.logoImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)rememberThePasswordAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    [[NSUserDefaults standardUserDefaults] setBool:btn.selected forKey:rememberThePasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark get
-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc]init];
        _logoImg.image = PNGIMAGE(@"logo");
    }
    return _logoImg;
}
-(UIButton *)loginBT{
    if (!_loginBT) {
        _loginBT = [[UIButton alloc]init];
        [_loginBT setBackgroundImage:PNGIMAGE(@"login_Bt_Img") forState:UIControlStateNormal];
        [_loginBT setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginBT;
}
-(UIButton *)forgetPwBT{
    if (!_forgetPwBT) {
        _forgetPwBT = [[UIButton alloc]init];
        [_forgetPwBT setTitleColor:kAppColorTextLightBlack forState:UIControlStateNormal];
        [_forgetPwBT setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPwBT.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetPwBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _forgetPwBT;
}

-(UIButton *)rememberThePasswordBtn{
    if (!_rememberThePasswordBtn) {
        _rememberThePasswordBtn = [[UIButton alloc]init];
        [_rememberThePasswordBtn setTitleColor:kAppColorTextLightBlack forState:UIControlStateNormal];
        [_rememberThePasswordBtn setTitle:@"自动登录" forState:UIControlStateNormal];
        _rememberThePasswordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rememberThePasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_rememberThePasswordBtn addTarget:self action:@selector(rememberThePasswordAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_rememberThePasswordBtn setImage:PNGIMAGE(@"chb_n") forState:(UIControlStateNormal)];
        [_rememberThePasswordBtn setImage:PNGIMAGE(@"chb_s") forState:(UIControlStateSelected)];
        _rememberThePasswordBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:rememberThePasswordKey];

    }
    return _rememberThePasswordBtn;
}

@end
