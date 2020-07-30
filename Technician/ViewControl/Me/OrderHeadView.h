//
//  OrderHeadView.h
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *toBeConfirmedBtn;
@property (weak, nonatomic) IBOutlet UIButton *forThePaymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *forTheServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *methodLabel;
@property (weak, nonatomic) IBOutlet UILabel *discreptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *staduesBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stepViewHeight;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIView *stepBgView;

@end
