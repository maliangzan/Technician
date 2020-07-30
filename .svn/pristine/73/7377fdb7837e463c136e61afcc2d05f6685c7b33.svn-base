//
//  WalletViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "WalletViewController.h"
#import "IncomeDetailsVC.h"
#import "WalletStatementCell.h"
#import "PaymentMethodViewController.h"

static NSString *walletCellID = @"WalletStatementCell";
@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *moneyLabel;
@property(nonatomic, strong)UILabel *balanceLabel;
@property(nonatomic, strong)UIButton *ruleBtn;
@property(nonatomic, strong)UIButton *withdrawalsBtn;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UILabel *leftLineLabel;
@property(nonatomic, strong)UILabel *rightLineLabel;
@property (nonatomic,strong)UILabel *middleLabel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kAppColorBackground;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 1)];
        [view setBackgroundColor:[UIColor whiteColor]];
        _tableView.tableHeaderView = view;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [_tableView registerNib:[UINib nibWithNibName:walletCellID bundle:nil] forCellReuseIdentifier:walletCellID];
    }
    return _tableView;
}
-(UIButton *)ruleBtn{
    if (!_ruleBtn) {
        _ruleBtn = [[UIButton alloc]init];
        [_ruleBtn setImage:PNGIMAGE(@"img_rule") forState:(UIControlStateNormal)];
        [_ruleBtn setTitle:Localized(@"提现规则") forState:(UIControlStateNormal)];
        [_ruleBtn setTitleColor:kAppColorTextLightBlack forState:(UIControlStateNormal)];
        _ruleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_ruleBtn addTarget:self action:@selector(showWithDrawalRules) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _ruleBtn;
}
-(UIButton *)withdrawalsBtn{
    if (!_withdrawalsBtn) {
        _withdrawalsBtn = [[UIButton alloc]init];
        [_withdrawalsBtn setBackgroundColor:getColor(@"1cc6a2")];
        [_withdrawalsBtn setTitle:@"提现（可提现150000元）" forState:UIControlStateNormal];
        _withdrawalsBtn.layer.cornerRadius = 3;
        _withdrawalsBtn.layer.masksToBounds = YES;
        [_withdrawalsBtn addTarget:self action:@selector(paymentMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _withdrawalsBtn;
}
-(UILabel *)balanceLabel{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc]init];
        [_balanceLabel setText:@"余额（元）"];
        [_balanceLabel setTextColor:[UIColor grayColor]];
        _balanceLabel.font = [UIFont systemFontOfSize:15*kHeightFactor];
    }
    return _balanceLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        [_moneyLabel setText:@"278.10"];
        [_moneyLabel setTextColor:[UIColor colorWithRed:245.0/255 green:104.0/255 blue:49.0/255 alpha:1.0]];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:40*kHeightFactor];
    }
    return _moneyLabel;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setBackgroundColor:[UIColor whiteColor]];
    }
    return _imageView;
}
-(UILabel *)leftLineLabel{
    if (!_leftLineLabel) {
        _leftLineLabel = [[UILabel alloc]init];
        [_leftLineLabel setBackgroundColor:getColor(@"e2e5e7")];
    }
    return _leftLineLabel;
}

-(UILabel *)rightLineLabel{
    if (!_rightLineLabel) {
        _rightLineLabel = [[UILabel alloc]init];
        [_rightLineLabel setBackgroundColor:getColor(@"e2e5e7")];
    }
    return _rightLineLabel;
}

- (UILabel *)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [[UILabel alloc] init];
        _middleLabel.text = Localized(@"对账单");
        _middleLabel.textColor = kAppColorTextLightBlack;
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _middleLabel;
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"我的钱包";
    [self.moreBtn setHidden:NO];
    [self.moreBtn setTitle:@"收益明细" forState:UIControlStateNormal];
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.rightBtn =^{
        NSLog(@"点击收益明细");
        [weakSelf.navigationController pushViewController:[IncomeDetailsVC new] animated:YES];
    };
    
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(70*kWidthFactor);
        make.height.mas_equalTo(170*kHeightFactor);
    }];
    
    [self.imageView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imageView);
    }];
    
    [self.imageView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.moneyLabel.mas_top).offset(-5*kHeightFactor);
        make.centerX.equalTo(self.imageView);
    }];
    
    [self.imageView addSubview:self.withdrawalsBtn];
    [self.withdrawalsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView).offset(20*kWidthFactor);
        make.right.equalTo(self.imageView).offset(-20*kWidthFactor);
        make.centerX.equalTo(self.imageView);
        make.bottom.equalTo(self.imageView).offset(-10*kHeightFactor);
    }];
    [self.imageView addSubview:self.ruleBtn];
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.withdrawalsBtn);
        make.bottom.equalTo(self.withdrawalsBtn).offset(-35*kHeightFactor);
    }];
    
    [self.view addSubview:self.leftLineLabel];
    [self .leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-APP_Frame_Width/2 - 40);
        make.top.equalTo(self.imageView.mas_bottom).offset(15*kHeightFactor);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.view addSubview:self.middleLabel];
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(5*kHeightFactor);
        make.height.mas_equalTo(@21);
    }];
    
    [self.view addSubview:self.rightLineLabel];
    [self .rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view).offset(APP_Frame_Width/2 + 40);
        make.top.equalTo(self.imageView.mas_bottom).offset(15*kHeightFactor);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(30*kHeightFactor);
        make.bottom.equalTo(self.view);
        
    }];
}

#pragma mark method
- (void)paymentMethod{
    //选择付款方式
    PaymentMethodViewController *vc = [[PaymentMethodViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showWithDrawalRules{
    [SVProgressHUD showInfoWithStatus:@"提现规则"];
}

- (void)configWalletStatementCell:(WalletStatementCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if ([dic[@"value"] integerValue] >= 0) {
        cell.valueLabel.textColor = kAppColorLightGreen;
    }else{
        cell.valueLabel.textColor = kAppColorAuxiliaryLightOrange;
    }
    cell.detailBtnWidth.constant = 0;
    cell.titleLabel.text = dic[@"title"];
    cell.timeLabel.text = dic[@"time"];
    cell.valueLabel.text = dic[@"value"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletStatementCell * cell = [tableView dequeueReusableCellWithIdentifier:walletCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configWalletStatementCell:cell atIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0*kHeightFactor;
}

#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
//    return PNGIMAGE(@"cf-message-empty");
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无对账单");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}
#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
                                                      
  @{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
  ,@{@"title":@"推荐奖励",@"time":@"2016-09-25  16:54:57",@"value":@"-456"}
  ,@{@"title":@"返还",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
  ,@{@"title":@"注册奖励",@"time":@"2016-09-25  16:54:57",@"value":@"-456"}
  ,@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
  ,@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
  ,@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
  ,@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"-456"}
  ,@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"-456"}
  
  ]];
    }
    return _dataArray;
}


@end
