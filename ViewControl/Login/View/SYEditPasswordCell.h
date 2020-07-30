//
//  SYEditPasswordCell.h
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYEditPasswordCellDelegate <NSObject>

- (void)commitPassword:(UIButton *)sender originalPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword newPasswordAgain:(NSString *)passwordAgain;

@end

@interface SYEditPasswordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *originalPasswordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic,weak) id<SYEditPasswordCellDelegate> delegate;

@end
