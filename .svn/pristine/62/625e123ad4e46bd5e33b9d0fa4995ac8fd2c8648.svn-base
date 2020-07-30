//
//  SYBanckListView.m
//  Technician
//
//  Created by TianQian on 2017/5/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYBanckListView.h"

@implementation SYBanckListView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.selectedIndex = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, KscreenWidth, 1)];
    line.backgroundColor = kAppColorBackground;
    [cell.contentView addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kAppColorAuxiliaryGreen;
    self.selectedIndex = indexPath.row;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    self.selectedIndex = indexPath.row;
}

#pragma mark - <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    //    return PNGIMAGE(@"cf-message-empty");
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无可选银行");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}

#pragma mark action
- (IBAction)cancelAction:(UIButton *)sender {
    [self.delegate cancelBank];
}

- (IBAction)sureAction:(UIButton *)sender {
    [self.delegate sureBankAtIndex:self.selectedIndex];
}

@end
