//
//  BaseForgetVC.h
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BaseLoginVC.h"
#import "JKCountDownButton.h"
@interface BaseForgetRegisterVC : BaseLoginVC
@property (nonatomic , strong) UITextField *nameTextField;
@property (nonatomic , strong) UITextField *PWTextField;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , strong) JKCountDownButton *codeBtn;
@property (nonatomic , strong) UIButton *submitBtn;
@property (nonatomic , strong) UIImageView *nameImg;
@property (nonatomic,strong) UIImageView *pwImg;
@property (nonatomic,strong) UIImageView *codeImg;
@property (nonatomic,copy) NSString *code;

- (NSString *)nameImageViewImageName;
- (NSString *)passwoedImageViewImageName;
- (NSString *)codeImageViewImageName;

- (void)getVerificationCodeWithPhoneNum:(NSString *)phone codeTextFeild:(UITextField *)codeTextFeild;

- (void)registerNewAccountWithPhoneNum:(NSString *)phone password:(NSString *)password codeTextFeild:(UITextField *)codeTextFeild;

@end
