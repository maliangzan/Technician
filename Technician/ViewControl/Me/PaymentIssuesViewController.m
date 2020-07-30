//
//  PaymentIssuesViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentIssuesViewController.h"
#import "PaymentIssuesCell.h"

static NSString *paymentIssuesCellID = @"PaymentIssuesCell";
@interface PaymentIssuesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation PaymentIssuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"支付问题";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];

}
#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaymentIssuesCell *cell = [tableView dequeueReusableCellWithIdentifier:paymentIssuesCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
    cell.titleLabel.text = dic[@"title"];
    cell.contentLabel.text = dic[@"content"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.section];
    return 80 + [NSString heightForString:dic[@"content"] labelWidth:KscreenWidth - 40 fontOfSize:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    head.backgroundColor = kAppColorBackground;
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:paymentIssuesCellID bundle:nil] forCellReuseIdentifier:paymentIssuesCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"支付不了",@"content":@"1、请查看网络状态，最好在有WIFI的状态下支付更快哦。\n2、可能遇到幸孕儿正在升级哦，请您稍后再尝试。如还是不行，请联系在线客服。"},@{@"title":@"银行跳转不了",@"content":@"1、请查看网络状态，最好在有WIFI的状态下支付更快哦。\n2、可能遇到幸孕儿正在升级哦，请您稍后再尝试。如还是不行，请联系在线客服。"},]];
    }
    return _dataArray;
}

@end
