//
//  PaymentSureViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentSureViewController.h"
#import "PaymentSureBackView.h"
#import "SYPaymentSureApi.h"


@interface PaymentSureViewController ()<PaymentSureBackViewDelegate>
@property (nonatomic,strong) PaymentSureBackView *paymentSureBackView;
@property (nonatomic,strong) SYPaymentToBankMode *paymentToBankMode;
@end

@implementation PaymentSureViewController

- (instancetype)initWithPaymentToBankMode:(SYPaymentToBankMode *)mode{
    if (self = [super init]) {
        _paymentToBankMode = mode;
    }
    return self;
}

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

#pragma mark method

#pragma mark PaymentSureBackViewDelegate
- (void)surePaymentToBank{
    NSString *pwd = self.paymentSureBackView.passwordTextFeild.text;
    if (isNull(pwd)) {
        [self.view showHUDForError:Localized(@"请输入密码")];
        return;
    }

    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"提交中,请稍后...")];
    WeakSelf;
    [[[SYPaymentSureApi alloc] initWithPaymentToBankMode:_paymentToBankMode password:pwd]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             if ([request.responseObject[@"response"] boolValue]) {
                 PostNotificationWithName(kNotificationWalletViewControllerRefresh);
                 [[UIApplication sharedApplication].keyWindow showHUDForInfo:[NSString stringWithFormat:@"%@",Localized(@"提现成功！")]];
                 [weakself.navigationController popToRootViewControllerAnimated:YES];
             } else {
                 //提现错误提示
                 [weakself.view showHUDForInfo:[NSString stringWithFormat:@"%@",Localized(@"提现失败！")]];
             }
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器")];
     }];

}

#pragma mark 懒加载
- (PaymentSureBackView *)paymentSureBackView{
    if (!_paymentSureBackView) {
        _paymentSureBackView = [[NSBundle mainBundle] loadNibNamed:@"PaymentSureBackView" owner:nil options:nil][0];
        _paymentSureBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _paymentSureBackView.delegate = self;
        _paymentSureBackView.nameLabel.text = isNull(_paymentToBankMode.accountName) == YES ? @"":_paymentToBankMode.accountName;
        NSString *bankName = isNull(_paymentToBankMode.bankName) == YES ? @"":_paymentToBankMode.bankName;
        NSString *cardNum = isNull(_paymentToBankMode.accountNo) == YES ? @"":_paymentToBankMode.accountNo;
        if (cardNum.length > 5 ) {
            cardNum = [cardNum substringWithRange:NSMakeRange(cardNum.length - 4, 4)];
        }
        _paymentSureBackView.bankLabel.text = [NSString stringWithFormat:@"%@(%@)",bankName,cardNum];
        _paymentSureBackView.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",[_paymentToBankMode.amount floatValue] / 100.0];
        NSString *imageName = [NSString stringWithFormat:@"%@bank",_paymentToBankMode.bankID];
        [_paymentSureBackView.bankIconBtn setImage:PNGIMAGE(imageName) forState:(UIControlStateNormal)];
    }
    return _paymentSureBackView;
}

@end
