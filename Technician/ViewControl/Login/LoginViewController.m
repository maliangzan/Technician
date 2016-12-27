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
#import "HomeViewController.h"
#import "OrdersViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"

@interface LoginViewController ()
@property (nonatomic , strong) UIImageView *logoImg;
@property (nonatomic , strong) UITextField *nameTextField;
@property (nonatomic , strong) UITextField *PWTextField;
@property (nonatomic , strong) UIButton *loginBT;
@property (nonatomic , strong) UIButton *forgetPwBT;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotificationCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
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
        [_forgetPwBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forgetPwBT setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetPwBT.titleLabel.font = [UIFont systemFontOfSize:15];
        _forgetPwBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _forgetPwBT;
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
}
- (void)dealloc{
    [self unRegisterNotificationCenter];
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
    self.PWTextField.secureTextEntry = YES;
    UIImageView *nameImg = [self createInputViewReferTo:self.nameTextField IconImgStr:@"user_name_Img"];
    UIImageView *pwImg = [self createInputViewReferTo:self.PWTextField IconImgStr:@"password_Img"];
    
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
    
    [self.actionBtn setTitle:@"没有账号>>" forState:UIControlStateNormal];
    
    [self.loginBT addTarget:self action:@selector(handleSignInAction) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPwBT addTarget:self action:@selector(handleForgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.actionBtn addTarget:self action:@selector(handleRegisterAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)handleSignInAction{
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    OrdersViewController *ordersVC = [[OrdersViewController alloc]init];
    FindViewController *findVC = [[FindViewController alloc]init];
    MeViewController *meVC = [[MeViewController alloc]init];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc]initWithTitle:@"工作室" image:PNGIMAGE(@"Home_tab_Item_default") selectedImage:PNGIMAGE(@"Home_tab_Item_select")];
    UITabBarItem *ordersItem = [[UITabBarItem alloc]initWithTitle:@"接单" image:PNGIMAGE(@"Orders_tab_Item_default") selectedImage:PNGIMAGE(@"Orders_tab_Item_select")];
    UITabBarItem *findItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:PNGIMAGE(@"Find_tab_Item_default") selectedImage:PNGIMAGE(@"Find_tab_Item_select")];
    UITabBarItem *meItem = [[UITabBarItem alloc]initWithTitle:@"我" image:PNGIMAGE(@"Me_tab_Item_default") selectedImage:PNGIMAGE(@"Me_tab_Item_select")];
    
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:getColor(@"1cc6a2"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [ordersItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:getColor(@"1cc6a2"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [findItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:getColor(@"1cc6a2"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [meItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:getColor(@"1cc6a2"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [homeVC setTabBarItem:homeItem];
    [ordersVC setTabBarItem:ordersItem];
    [findVC setTabBarItem:findItem];
    [meVC setTabBarItem:meItem];
    
    [tabBar setViewControllers:[NSArray arrayWithObjects:homeVC,ordersVC,findVC,meVC, nil]];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    backView.backgroundColor = RGB(244, 245, 246);
    backView.alpha = 1.0;
    [tabBar.tabBar insertSubview:backView atIndex:0];
    tabBar.tabBar.opaque = YES;
    
    tabBar.fd_prefersNavigationBarHidden = YES;
    [self.navigationController pushViewController:tabBar animated:YES];
    
}
-(void)handleForgetAction{
    ForgetViewController *forgetVC = [[ForgetViewController alloc]init];
    forgetVC.title = @"重置密码";
    [forgetVC.submitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    forgetVC.actionBtn.hidden = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
}
-(void)handleRegisterAction{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [registerVC.submitBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.navigationController pushViewController:registerVC animated:YES];
}
@end
