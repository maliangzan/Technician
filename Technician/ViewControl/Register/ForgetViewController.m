//
//  ForgetViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    [super buildUI];
    self.fd_prefersNavigationBarHidden = NO;
    [self.nameImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50*kHeightFactor);
    }];
    self.nameTextField.placeholder = @"输入新密码";
    self.PWTextField.placeholder = @"再次输入新密码";
    self.codeTextField.placeholder = @"输入验证码";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
