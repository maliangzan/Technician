//
//  PaymentSureViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentSureViewController.h"
#import "PaymentSureBackView.h"

@interface PaymentSureViewController ()<PaymentSureBackViewDelegate>
@property (nonatomic,strong) PaymentSureBackView *paymentSureBackView;
@end

@implementation PaymentSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"确认提现");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.paymentSureBackView];
}

#pragma mark PaymentSureBackViewDelegate
- (void)surePaymentToBank{
    [SVProgressHUD showInfoWithStatus:@"确认提现"];
}

#pragma mark 懒加载
- (PaymentSureBackView *)paymentSureBackView{
    if (!_paymentSureBackView) {
        _paymentSureBackView = [[NSBundle mainBundle] loadNibNamed:@"PaymentSureBackView" owner:nil options:nil][0];
        _paymentSureBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _paymentSureBackView.delegate = self;
    }
    return _paymentSureBackView;
}

@end
