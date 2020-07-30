//
//  BaseForgetVC.m
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BaseForgetRegisterVC.h"
#import <ReactiveCocoa.h>
#import "GetVerificationCodeApi.h"


@interface BaseForgetRegisterVC ()
@property (nonatomic, strong) RACSignal *verifyValidSignal;
@property (nonatomic,assign) BOOL isEditingLoginName;


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
        [_submitBtn addTarget:self action:@selector(registerAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _submitBtn;
}
-(JKCountDownButton *)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [[JKCountDownButton alloc]init];
        [_codeBtn setBackgroundColor:[UIColor whiteColor]];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:accountKey];
        if ([account isValidPhone]) {
            [_codeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:UIControlStateNormal];
        }else{
            [_codeBtn setTitleColor:kAppColorTextLightBlack forState:UIControlStateNormal];
        }
        
        [_codeBtn addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
        
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

    }
    return _codeBtn;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (NSString *)nameImageViewImageName{
    return @"user_name_Img";
}

- (NSString *)passwoedImageViewImageName{
    return @"password_Img";
}

- (NSString *)codeImageViewImageName{
    return @"verification_Code";
}

-(void)buildUI{
    [super buildUI];
    self.nameTextField = [self textFieldWithPlaceHolder:nil];
    self.PWTextField = [self textFieldWithPlaceHolder:nil];
    self.codeTextField = [self textFieldWithPlaceHolder:nil];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    nameImg = [self createInputViewReferTo:self.nameTextField IconImgStr:[self nameImageViewImageName]];
    self.pwImg = [self createInputViewReferTo:self.PWTextField IconImgStr:[self passwoedImageViewImageName]];
    self.codeImg = [self createInputViewReferTo:self.codeTextField IconImgStr:[self codeImageViewImageName]];
    
    [self.view addSubview:nameImg];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.view).offset(101*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:self.pwImg];
    [self.pwImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(nameImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:self.codeImg];
    [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-100*kWidthFactor);
        make.top.equalTo(self.pwImg.mas_bottom).offset(16*kHeightFactor);
        make.height.mas_offset(40*kHeightFactor);
    }];
    
    [self.view addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeImg.mas_right).offset(-20);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.pwImg.mas_bottom).offset(16*kHeightFactor);
        make.height.equalTo(self.codeImg);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.right.equalTo(self.view).offset(-20*kWidthFactor);
        make.top.equalTo(self.codeImg.mas_bottom).offset(42*kHeightFactor);
        make.height.mas_offset(39*kHeightFactor);
    }];
    
    [self bindData];
}

- (void)getVerificationCodeAction{
    NSString *phoneNum = self.nameTextField.text;
    if (![phoneNum isValidPhone]) {
        [self.view showHUDForError:Localized(@"请输入正确的电话号码！")];
        return;
    }
    
    if ([self respondsToSelector:@selector(getVerificationCodeWithPhoneNum:codeTextFeild:)]) {
        [self getVerificationCodeWithPhoneNum:phoneNum codeTextFeild:self.codeTextField];
    }
}


- (void)getVerificationCodeWithPhoneNum:(NSString *)phone codeTextFeild:(UITextField *)codeTextFeild{
    WeakSelf;
    [[[GetVerificationCodeApi alloc] initWithPhoneNum:phone]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             [weakself.view showHUDForSuccess:Localized(@"获取验证码成功，请注意查收！")];
             weakself.code = [request.responseObject[@"data"] stringValue];
             NSLog(@"%@",weakself.code);
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
     }];
}

- (void)registerAction{
    [self.view endEditing:YES];
    if ([self respondsToSelector:@selector(registerNewAccountWithPhoneNum:password:codeTextFeild:)]) {
        [self registerNewAccountWithPhoneNum:self.nameTextField.text password:self.PWTextField.text codeTextFeild:self.codeTextField];
    }
}

#pragma mark - bindData
- (void)bindData {
    self.nameTextField.text = [SYAppConfig shared].me.loginName;
    RAC(self.codeBtn, enabled) = self.verifyValidSignal;
}

- (RACSignal *)verifyValidSignal {
    if ( !_verifyValidSignal) {
        _verifyValidSignal = [[self.nameTextField.rac_textSignal distinctUntilChanged] map:^id(NSString *verify) {
            
            if ( verify.length == 11 && [verify isValidPhone]) {
                [_codeBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:UIControlStateNormal];
                
                return @YES;
            } else {
                [_codeBtn setTitleColor:kAppColorTextLightBlack forState:UIControlStateNormal];
                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                return @NO;
            }
    }];
    }
    return _verifyValidSignal;
}


@end
