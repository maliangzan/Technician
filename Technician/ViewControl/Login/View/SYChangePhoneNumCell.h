//
//  SYChangePhoneNumCell.h
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYChangePhoneNumCellDelegate <NSObject>

- (void)gettingErificationCode;
- (void)commitNewPhoneNum:(NSString *)phoneNum;

@end

@interface SYChangePhoneNumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic,weak) id<SYChangePhoneNumCellDelegate> delegate;

@end
