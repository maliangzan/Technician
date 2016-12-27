//
//  BaseLoginRegisterVC.h
//  Technician
//
//  Created by 马良赞 on 16/12/22.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "BackGroundViewController.h"

@interface BaseLoginVC : BackGroundViewController
@property (nonatomic , strong) UIButton *actionBtn;
- (UIImageView *)createInputViewReferTo:(UITextField *)textfield IconImgStr:(NSString *)name;
- (UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder;
@end
