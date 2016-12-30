//
//  HomeViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "HomeViewController.h"
#import "OCHomeHeaderView.h"
#import "OrdersCell.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UILabel *moneyLab;
@property(nonatomic, strong)UIButton *noticeBtn;
@property(nonatomic, strong)UIButton *ordersBtn;
@end

@implementation HomeViewController

-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 120)];
        _moneyLab.numberOfLines = 0;
        _moneyLab.textColor = [UIColor grayColor];
        _moneyLab.backgroundColor = [UIColor whiteColor];
        _moneyLab.textAlignment = NSTextAlignmentCenter;
        _moneyLab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        NSString *numStr = @"21000.00";
        NSString *inteStr = [NSString stringWithFormat:@"总金额(元)￥\n%@",numStr];
        
        NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:inteStr];
        
        NSRange orangeRange = NSMakeRange([[inteMutStr string] rangeOfString:numStr].location, [[inteMutStr string] rangeOfString:numStr].length);
        [inteMutStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:orangeRange];
        [inteMutStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:orangeRange];
        
        [_moneyLab setAttributedText:inteMutStr];
    }
    return _moneyLab;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.moneyLab;
    }
    return _tableView;
}
-(UIButton *)noticeBtn{
    if (!_noticeBtn) {
        _noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noticeBtn setBackgroundImage:PNGIMAGE(@"home_notice_btn") forState:UIControlStateNormal];
    }
    return _noticeBtn;
}
-(UIButton *)ordersBtn{
    if (!_ordersBtn) {
        _ordersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ordersBtn setBackgroundImage:PNGIMAGE(@"home_in_orders_btn") forState:UIControlStateNormal];
    }
    return _ordersBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buildUI{
    [super buildUI];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[OrdersCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.noticeBtn];
    [self.view addSubview:self.ordersBtn];
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20*kWidthFactor);
        make.top.equalTo(self.view).offset(40*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(17*kWidthFactor, 25*kHeightFactor));
    }];
    [self.ordersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40*kHeightFactor);
        make.right.equalTo(self.view).offset(-10*kWidthFactor);
        make.size.mas_equalTo(CGSizeMake(43*kWidthFactor, 27*kHeightFactor));
    }];
    
}
#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrdersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.0*kHeightFactor;
}
//- (CGFloat)tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
//{
//    return 0.0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSString *reuseIdetify = [NSString stringWithFormat:@"OCHomeHeaderView"];
//    OCHomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdetify];
//    if (!headerView) {
//        headerView = [[OCHomeHeaderView alloc]initWithReuseIdentifier:reuseIdetify];
//    }
//    headerView.titlelab.text = @"123";
//    return headerView;}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.0;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
