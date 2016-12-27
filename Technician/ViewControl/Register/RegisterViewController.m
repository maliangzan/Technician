//
//  RegisterViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "RegisterViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)buildUI{
    [super buildUI];
    self.nameTextField.placeholder = @"输入手机号";
    self.PWTextField.placeholder = @"输入密码";
    self.codeTextField.placeholder = @"输入验证码";
    
    [self.actionBtn setTitle:@"账号登录>>" forState:UIControlStateNormal];
    [self.actionBtn addTarget:self action:@selector(handleBackInAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)handleBackInAction{
     [self.navigationController popViewControllerAnimated:YES];
}

@end
