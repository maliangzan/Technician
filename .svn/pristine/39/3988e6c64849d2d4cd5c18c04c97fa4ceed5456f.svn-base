//
//  PaymentToBankViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentToBankViewController.h"
#import "PaymentToBankBackView.h"
#import "PaymentSureViewController.h"

@interface PaymentToBankViewController ()<PaymentToBankBackViewDelegate>
@property (nonatomic,strong) PaymentToBankBackView *paymentToBankBackView;
@end

@implementation PaymentToBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"提现至银行卡");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.paymentToBankBackView];
}

#pragma mark PaymentToBankBackViewDelegate
- (void)selectBank{
    [SVProgressHUD showInfoWithStatus:@"选择银行"];
}

- (void)nextStep{
    PaymentSureViewController *vc = [[PaymentSureViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 懒加载
- (PaymentToBankBackView *)paymentToBankBackView{
    if (!_paymentToBankBackView) {
        _paymentToBankBackView = [[NSBundle mainBundle] loadNibNamed:@"PaymentToBankBackView" owner:nil options:nil][0];
        _paymentToBankBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _paymentToBankBackView.delegate = self;
    }
    return _paymentToBankBackView;
}

@end
