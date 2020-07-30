//
//  ChangePhoneNumViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/26.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ChangePhoneNumViewController.h"
#import "SYChangePhoneNumApi.h"

@interface ChangePhoneNumViewController ()
@property (nonatomic,strong) UILabel *tipsLabel;
@end

@implementation ChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark superMethod
- (NSString *)nameImageViewImageName{
    return @"img_mobilePhone";
}

-(void)buildUI{
    [super buildUI];
    self.navImg.hidden = NO;
    self.backBtn.hidden = NO;
    self.bigBackButton.hidden = NO;
    
    self.titleLabel.text = Localized(@"更改手机号");
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.nameImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50*kHeightFactor + kCustomNavHeight);
    }];
    
    self.nameTextField.text = @"";
    self.nameTextField.placeholder = Localized(@"输入新手机号");
    self.PWTextField.placeholder = Localized(@"输入身份证账号码");
    self.codeTextField.placeholder = Localized(@"输入验证码");
    [self.submitBtn addTarget:self action:@selector(handleSubmitInAction)  forControlEvents:UIControlEventTouchUpInside];
    self.title = Localized(@"取回密码");
    [self.submitBtn setTitle:Localized(@"确定更改") forState:UIControlStateNormal];
    self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.codeImg.mas_bottom).offset(3);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
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
    
}
-(void)handleSubmitInAction{
    
    NSString *loginName = self.nameTextField.text;
    if (isNull(loginName)) {
        [self.view showHUDForError:Localized(@"请输入新手机号！")];
        return;
    }
    
    if (![loginName isValidPhone]) {
        [self.view showHUDForError:Localized(@"请输入正确的手机号！")];
        return;
    }
    
    NSString *inputCode = self.codeTextField.text;
    if (![inputCode isEqualToString:self.code]) {
        [self.view showHUDForError:Localized(@"验证码错误，请重新输入！")];
        return;
    }
    
    WeakSelf;
    [[[SYChangePhoneNumApi alloc] initWithLoginName:loginName userID:[SYAppConfig shared].me.userID]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [[UIApplication sharedApplication].keyWindow showHUDForSuccess:Localized(@"手机号修改成功！")];
             [SYAppConfig shared].me.loginName = loginName;
             [weakself.navigationController popViewControllerAnimated:YES];
             
             NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
             [df setObject:loginName forKey:accountKey];
             [df synchronize];
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"未连接到服务器，身份验证失败！")];
     }];
    
}

#pragma mark 懒加载
- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = kAppColorTextLightBlack;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = Localized(@"更换后个人信息不变，下次请使用新手机号登录");
        _tipsLabel.font = [UIFont systemFontOfSize:14];
    }
    return _tipsLabel;
}


@end
