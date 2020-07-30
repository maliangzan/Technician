//
//  OrderListBaseViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderListBaseViewController.h"
#import "OrderListBaseCell.h"
#import "OrderDetailViewController.h"
#import "ServiceTimeViewController.h"

static NSString *orderCellID = @"OrderListBaseCell";
@interface OrderListBaseViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,OrderListBaseCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *emptyBtn;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation OrderListBaseViewController

- (instancetype)initWithOrderStadues:(SYOrderStadues)orderStadues{
    if ([super init]) {
        self.orderStadues = orderStadues;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

#pragma mark method
- (void)setupUI{
    [self.view addSubview:self.tableView];
    if (self.dataArray.count > 0) {
        [self.emptyBtn removeFromSuperview];
    }else{
        [self.tableView addSubview:self.emptyBtn];
    }
}

- (void)addOrder:(UIButton *)btn{
    [SVProgressHUD showErrorWithStatus:@"addOrder"];
}

#pragma mark OrderListBaseCellDelegate
- (void)clickStaduesBtnAtCell:(OrderListBaseCell *)cell{
    switch (self.orderStadues) {
        case SYOrderStaduesAll:
        {
        }
            break;
        case SYOrderStaduesToBeConfirmed:
        {
        }
            break;
        case SYOrderStaduesForThePayment:
        {
        }
            break;
        case SYOrderStaduesForTheService:
        {
            ServiceTimeViewController *serviceTimeVC = [[ServiceTimeViewController alloc] init];
            [self.navigationController pushViewController:serviceTimeVC animated:YES];
        }
            break;
        case SYOrderStaduesComplete:
        {
        }
            break;
            
        default:
            break;
    }
   
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    switch (self.orderStadues) {
        case SYOrderStaduesAll:
        {
            
        }
            break;
        case SYOrderStaduesToBeConfirmed:
        {
            [cell.staduesBtn setTitle:Localized(@"待确认") forState:(UIControlStateNormal)];
            [cell.staduesBtn setImage:nil forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesForThePayment:
        {
            [cell.staduesBtn setTitle:Localized(@"待付款") forState:(UIControlStateNormal)];
            [cell.staduesBtn setImage:nil forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesForTheService:
        {
            [cell.staduesBtn setTitle:Localized(@"开始") forState:(UIControlStateNormal)];
            [cell.staduesBtn setImage:nil forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesComplete:
        {
            [cell.staduesBtn setTitle:Localized(@"已完成") forState:(UIControlStateNormal)];
            [cell.staduesBtn setImage:nil forState:(UIControlStateNormal)];
            cell.staduesBtn.backgroundColor = kAppColorTextLightBlack;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] initWithOrderStadues:self.orderStadues];
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return PNGIMAGE(@"pic_nothing");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"喵～ 你从未飘过～\n555～  伦家已经哭倒在地了");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -120 * kHeightFactor;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource= self;
        _tableView.emptyDataSetDelegate  =self;
        [_tableView registerNib:[UINib nibWithNibName:orderCellID bundle:nil] forCellReuseIdentifier:orderCellID];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null]]];
    }
    return _dataArray;
}

- (UIButton *)emptyBtn{
    if (!_emptyBtn) {
        _emptyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _emptyBtn.frame = CGRectMake(KscreenWidth / 2 - 80, 220 * kHeightFactor, 160, 40);
        [_emptyBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateNormal)];
        [_emptyBtn setTitle:Localized(@"现在看看>>") forState:(UIControlStateNormal)];
        [_emptyBtn addTarget:self action:@selector(addOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _emptyBtn;
}
@end
