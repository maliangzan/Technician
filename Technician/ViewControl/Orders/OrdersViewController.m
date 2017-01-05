//
//  OrdersViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrdersCell.h"
#import "OCHomeHeaderView.h"
#import "serviceDetailsVC.h"
@interface OrdersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 1)];
        [view setBackgroundColor:[UIColor whiteColor]];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}
-(void)buildUI{
    [super buildUI];
    self.backBtn.hidden = YES;
    self.titleLabel.text = @"服务接单";
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
        
    }];
    [self.tableView registerClass:[OrdersCell class] forCellReuseIdentifier:@"cell"];
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
- (CGFloat)tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *reuseIdetify = [NSString stringWithFormat:@"OCHomeHeaderView"];
    OCHomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdetify];
    if (!headerView) {
        headerView = [[OCHomeHeaderView alloc]initWithReuseIdentifier:reuseIdetify];
    }
    headerView.titlelab.text = @"123";
    return headerView;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tabBarController.navigationController pushViewController:[serviceDetailsVC new] animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
