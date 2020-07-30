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
#import "SYBanckListView.h"
#import "SYPaymentToBankMode.h"
#import "SYGetBankListApi.h"
#import "SYPaymentToBankNextStepApi.h"
#import "SYTheHistoricalRecordPaymentToBankNextStepApi.h"

@interface PaymentToBankViewController ()<PaymentToBankBackViewDelegate,SYBanckListViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) PaymentToBankBackView *paymentToBankBackView;
@property (nonatomic,strong) SYBanckListView *banckListView;
@property (nonatomic,strong) NSMutableArray *bankListArray;
@property (nonatomic,strong) NSMutableArray *bankNameArray;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) SYPaymentToBankMode *paymentToBankMode;
@property (nonatomic,assign) SYInComeType incomeType;
@property (nonatomic,strong) SYAccountMode *accountMode;
@end

@implementation PaymentToBankViewController

- (instancetype)initWithIncomeType:(SYInComeType)type accountMode:(SYAccountMode *)accountMode{
    if (self = [super init]) {
        self.incomeType = type;
        self.accountMode = accountMode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestBankList];
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

#pragma mark method
- (void)removeBackView{
    [self removeSubView];
}

- (void)removeSubView{
    [self.banckListView removeFromSuperview];
    [self.backView removeFromSuperview];
}

- (void)requestBankList{
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsTechnicianWithdrawCash/getBankList",URL_HTTP_Base_Get
                        ];
    SYGetBankListApi *api = [[SYGetBankListApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.bankListArray removeAllObjects];
        [weakself.bankListArray addObjectsFromArray:request.responseObject[@"data"]];
        weakself.banckListView.dataArray = weakself.bankNameArray;
        [weakself.banckListView.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        
        NSLog(@"%@", request.error);
    }];
}

#pragma mark PaymentToBankBackViewDelegate
- (void)selectBank{
    [self.view endEditing:YES];
    
    switch (self.incomeType) {
        case SYInComeTypeTheCommonlyUsed:
        {
            [self requestBankList];
            [self.view addSubview:self.backView];
            [self.view addSubview:self.banckListView];
            CGFloat viewH = 300;
            CGFloat viewW = KscreenWidth;
            CGFloat viewX = 0;
            CGFloat viewY = KscreenHeight - viewH;
            [UIView animateWithDuration:0.5 animations:^{
                _banckListView.frame = CGRectMake(viewX, viewY, viewW, viewH);
            }];
        }
            break;
        case SYInComeTypeTheHistoricalRecord:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)nextStep{
    [self.view endEditing:YES];
    
    if (isNull(self.paymentToBankMode.accountName)) {
        [self.view showHUDForError:Localized(@"请输入账户名")];
        return;
    }
    
    if (isNull(self.paymentToBankMode.accountNo)) {
        [self.view showHUDForError:Localized(@"请输入银行卡号")];
        return;
    }
    
//    if (![self.paymentToBankMode.accountNo isValidPhoneBankCard]) {
//        [self.view showHUDForError:Localized(@"请输入正确的银行卡号")];
//        return;
//    }
    
    if (isNull(self.paymentToBankMode.bankName)) {
        [self.view showHUDForError:Localized(@"请选择银行")];
        return;
    }
    
    if (isNull([self.paymentToBankMode.amount stringValue])) {
        [self.view showHUDForError:Localized(@"请输入提现金额")];
        return;
    }
    
    if ([self.paymentToBankMode.amount floatValue] > 10000.0) {
        [self.view showHUDForError:Localized(@"每日提现上限为10000元！")];
        return;
    }
    
    switch (self.incomeType) {
        case SYInComeTypeTheCommonlyUsed:
        {
            [self loadDataForInComeTypeCommonlyUsed];
        }
            break;
        case SYInComeTypeTheHistoricalRecord:
        {
            [self loadDataForTheHistoricalRecord];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)loadDataForInComeTypeCommonlyUsed{
    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"资料提交中...")];
    WeakSelf;
    [[[SYPaymentToBankNextStepApi alloc] initWithPaymentToBankMode:self.paymentToBankMode]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             if ([request.responseObject[@"response"] boolValue]) {
                 //可以提现
                 NSDictionary *dic = request.responseObject[@"data"];
                 weakself.paymentToBankMode = [SYPaymentToBankMode fromJSONDictionary:dic];
                 
                 PaymentSureViewController *vc = [[PaymentSureViewController alloc] initWithPaymentToBankMode:weakself.paymentToBankMode];
                 [weakself.navigationController pushViewController:vc animated:YES];
             } else {
                 //提现错误提示
                 [weakself.view showHUDForInfo:[NSString stringWithFormat:@"%@",request.responseObject[@"message"]]];
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

- (void)loadDataForTheHistoricalRecord{
    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"资料提交中...")];
    WeakSelf;
    [[[SYTheHistoricalRecordPaymentToBankNextStepApi alloc] initWithAccountMode:self.accountMode]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         if ([request isSuccess]) {
             if ([request.responseObject[@"response"] boolValue]) {
                 //可以提现
                 NSDictionary *dic = request.responseObject[@"data"];
                 weakself.paymentToBankMode = [SYPaymentToBankMode fromJSONDictionary:dic];
                 
                 PaymentSureViewController *vc = [[PaymentSureViewController alloc] initWithPaymentToBankMode:weakself.paymentToBankMode];
                 [weakself.navigationController pushViewController:vc animated:YES];
             } else {
                 //提现错误提示
                 [weakself.view showHUDForInfo:[NSString stringWithFormat:@"%@",request.responseObject[@"message"]]];
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

#pragma mark SYBanckListViewDelegate
- (void)cancelBank{
    [self removeSubView];
}

- (void)sureBankAtIndex:(NSInteger)index{
    [self removeSubView];
    if (!isNullArray(self.bankNameArray)) {
        self.paymentToBankBackView.bankLabel.text = self.bankNameArray[index];
        self.paymentToBankMode.bankName = self.bankNameArray[index];
        NSDictionary *dic = self.bankListArray[index];
        self.paymentToBankMode.bankID = dic[@"id"];
    }
    
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 100:
        {
            self.paymentToBankMode.accountName = textField.text;
        }
            break;
        case 101:
        {
            self.paymentToBankMode.accountNo = textField.text;
        }
            break;
        case 102:
        {
            NSNumber *amount = [NSNumber numberWithFloat:[textField.text floatValue] * 100];
            self.paymentToBankMode.amount = amount;
            self.accountMode.amount = amount;
        }
            break;
        default:
            break;
    }
}

#pragma mark 懒加载
- (PaymentToBankBackView *)paymentToBankBackView{
    if (!_paymentToBankBackView) {
        _paymentToBankBackView = [[NSBundle mainBundle] loadNibNamed:@"PaymentToBankBackView" owner:nil options:nil][0];
        _paymentToBankBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _paymentToBankBackView.delegate = self;
        _paymentToBankBackView.userNameTextFeild.delegate = self;
        _paymentToBankBackView.bankNumTextFeild.delegate = self;
        _paymentToBankBackView.moneyValueTextFeild.delegate = self;
        switch (self.incomeType) {
            case SYInComeTypeTheCommonlyUsed:
            {
                _paymentToBankBackView.userNameTextFeild.userInteractionEnabled = YES;
                _paymentToBankBackView.bankNumTextFeild.userInteractionEnabled = YES;
            }
                break;
            case SYInComeTypeTheHistoricalRecord:
            {
                _paymentToBankBackView.userNameTextFeild.userInteractionEnabled = NO;
                _paymentToBankBackView.bankNumTextFeild.userInteractionEnabled = NO;
                _paymentToBankBackView.userNameTextFeild.text = self.accountMode.accountName;
                _paymentToBankBackView.bankNumTextFeild.text = self.accountMode.accountNo;
                _paymentToBankBackView.bankLabel.text = self.accountMode.bankName;
                self.paymentToBankMode.bankName = self.accountMode.bankName;
                self.paymentToBankMode.bankID = self.accountMode.accountID;
            }
                break;
                
            default:
                break;
        }
        
    }
    return _paymentToBankBackView;
}

- (SYBanckListView *)banckListView{
    if (!_banckListView) {
        CGFloat viewH = 300;
        CGFloat viewW = KscreenWidth;
        CGFloat viewX = 0;
        CGFloat viewY = KscreenHeight;
        _banckListView = [[NSBundle mainBundle] loadNibNamed:@"SYBanckListView" owner:nil options:nil][0];
        _banckListView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        _banckListView.dataArray = self.bankNameArray;
        _banckListView.delegate = self;
    }
    return _banckListView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBackView)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (NSMutableArray *)bankNameArray{
    [_bankNameArray removeAllObjects];
    if (!_bankNameArray) {
        _bankNameArray = [NSMutableArray array];
    }
    for (NSDictionary *dic in self.bankListArray) {
        if (!isNullDictionary(dic)) {
            SYPaymentToBankMode *bankMode = [SYPaymentToBankMode fromJSONDictionary:dic];
            [_bankNameArray addObject:bankMode.bankName];
        }
    }
    return _bankNameArray;
}

- (NSMutableArray *)bankListArray{
    if (!_bankListArray) {
        _bankListArray = [NSMutableArray array];
    }
    return _bankListArray;
}

- (SYPaymentToBankMode *)paymentToBankMode{
    if (!_paymentToBankMode) {
        _paymentToBankMode = [[SYPaymentToBankMode alloc] init];
        _paymentToBankMode.accountName = self.accountMode.accountName;
        _paymentToBankMode.accountNo = self.accountMode.accountNo;
    }
    return _paymentToBankMode;
}

@end
