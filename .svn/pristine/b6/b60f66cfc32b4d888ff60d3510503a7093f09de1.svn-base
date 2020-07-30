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
- (void)configWalletStatementCell:(WalletStatementCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if ([dic[@"value"] integerValue] >= 0) {
        cell.valueLabel.textColor = kAppColorLightGreen;
        cell.detailBtn.hidden = YES;
    }else{
        cell.valueLabel.textColor = kAppColorAuxiliaryLightOrange;
        cell.detailBtn.hidden = NO;
    }
    
    cell.titleLabel.text = dic[@"title"];
    cell.timeLabel.text = dic[@"time"];
    cell.valueLabel.text = dic[@"value"];
}

#pragma mark WalletStatementCellDelegate
- (void)showDetailAtCell:(WalletStatementCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.delegate showDetailAtIndexPath:indexPath];
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
