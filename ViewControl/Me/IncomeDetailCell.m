//
//  IncomeDetailCell.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "IncomeDetailCell.h"

static NSString *walletCellID = @"WalletStatementCell";
@implementation IncomeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:walletCellID bundle:nil] forCellReuseIdentifier:walletCellID];
    
}

#pragma mark method
- (void)configCellWithDataArray:(NSArray *)array{
    //@{@"title":@"提现",@"time":@"2016-09-25  16:54:57",@"value":@"+456"}
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
}

- (void)configWalletStatementCell:(WalletStatementCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.detailBtnWidth.constant= 36;

    SYIncomeEarningMode *mode = [self.dataArray objectAtIndex:indexPath.row];

    cell.titleLabel.text = mode.serviceInfo[@"name"];
    cell.timeLabel.text = mode.createTime;
    cell.valueLabel.text = [NSString stringWithFormat:@"%.2f",[mode.amount floatValue] / 100.0];
}

#pragma mark WalletStatementCellDelegate
- (void)showDetailAtCell:(WalletStatementCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SYIncomeEarningMode *mode = [self.dataArray objectAtIndex:indexPath.row];
    [self.delegate showDetailWithMode:mode];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletStatementCell * cell = [tableView dequeueReusableCellWithIdentifier:walletCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
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
    NSString *text = Localized(@"暂无记录");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}
#pragma mark 懒加载

@end
