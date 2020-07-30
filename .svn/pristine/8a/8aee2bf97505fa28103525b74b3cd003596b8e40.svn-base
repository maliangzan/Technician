//
//  PaymentToBankView.h
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentToBankBackViewDelegate <NSObject>

- (void)selectBank;
- (void)nextStep;

@end

@interface PaymentToBankBackView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *bankNumTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *moneyValueTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

@property (nonatomic,weak) id<PaymentToBankBackViewDelegate> delegate;

@end
