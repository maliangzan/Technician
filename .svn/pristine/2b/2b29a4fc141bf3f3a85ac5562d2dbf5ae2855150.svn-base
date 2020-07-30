//
//  PaymentSureBackView.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentSureBackViewDelegate <NSObject>

- (void)surePaymentToBank;

@end

@interface PaymentSureBackView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankIconBtn;

@property (nonatomic,weak) id<PaymentSureBackViewDelegate> delegate;

@end
