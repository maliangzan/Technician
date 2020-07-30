//
//  SYTableCell.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYTableCell.h"
#import "TwoLabelCell.h"

static NSString *twoLabelCellID = @"TwoLabelCell";
@implementation SYTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = kAppColorBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:twoLabelCellID bundle:nil] forCellReuseIdentifier:twoLabelCellID];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kAppColorBackground;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *titleStr = dic[@"title"];
    if ([titleStr containsString:@"技师"] || [titleStr containsString:@"使用者"]) {
        cell.sexBtn.hidden =  NO;
    }else{
        cell.sexBtn.hidden =  YES;
    }

    cell.titleLabel.text = titleStr;
    cell.contentLabel.text = dic[@"content"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
