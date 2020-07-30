//
//  PaymentMethodViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentMethodViewController.h"
#import "PaymentToBankViewController.h"

#define HEAD_HEIGHT 40 * kHeightFactor
#define CELL_HEIGHT 50 * kHeightFactor

@interface PaymentMethodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation PaymentMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"选择收款方式");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;

    [self.view addSubview:self.tableView];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArray = [self.dataArray objectAtIndex:section];
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle      reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 1, KscreenWidth, 1)];
    line.backgroundColor = kAppColorBackground;
    [cell.contentView addSubview:line];
    
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dic = subArray[indexPath.row];
    cell.imageView.image = PNGIMAGE(dic[@"icon"]);
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.textColor = kAppColorTextLightBlack;
    cell.detailTextLabel.text = dic[@"subTitle"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.text = Localized(@"    历史");
    label.textColor = kAppColorTextLightBlack;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {}
                    break;
                case 1:
                {}
                    break;
                case 2:
                {
                    //提现到银行卡
                    PaymentToBankViewController *vc = [[PaymentToBankViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.tableHeaderView = self.headView;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, HEAD_HEIGHT)];
        _headView.backgroundColor = kAppColorBackground;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KscreenWidth - 40, HEAD_HEIGHT)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.text = Localized(@"为了保障您的财产安全，只能使用您本人的银行卡或账号提现。");
        label.textColor = kAppColorTextLightBlack;
        [_headView addSubview:label];
    }
    return _headView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
  @[
  @{@"icon":@"img_wechat",@"title":@"提现到微信钱包",@"subTitle":@""},
  @{@"icon":@"img_pay",@"title":@"提现到支付宝",@"subTitle":@""},
  @{@"icon":@"img_bankCard",@"title":@"提现到银行卡",@"subTitle":@""}
  ],
  @[
  @{@"icon":@"img_wechat",@"title":@"木子李",@"subTitle":@"1881****934"},
  @{@"icon":@"img_pay",@"title":@"木子李",@"subTitle":@"143****4@163.com"},
  @{@"icon":@"img_bankCard",@"title":@"木子李",@"subTitle":@"招商银行（**8878"}
  ]
  ]];
    }
    return _dataArray;
}

@end
