//
//  FeedbackView.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "FeedbackView.h"
#import "FeedBackViewCell.h"

static NSString *cellID = @"FeedBackViewCell";
@implementation FeedbackView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)configFeedbackViewWithInfoDic:(NSDictionary *)infoDic{
    if (!isNullDictionary(infoDic)) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObject:infoDic];
        [self.tableView reloadData];
    }
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedBackViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell==nil){
        cell=[[FeedBackViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *infoDic = [self.dataArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = infoDic[@"opinion"][@"createTime"];
    NSString *content = isNull(infoDic[@"opinion"][@"content"]) == YES ? @"" : infoDic[@"opinion"][@"content"];
    NSString *solution = isNull(infoDic[@"reply"][@"content"]) == YES ? @"" : infoDic[@"reply"][@"content"];
    NSString *contentStr = [NSString stringWithFormat:@"%@\n\n",content];
    if (!isNull(solution)) {
        contentStr = [NSString stringWithFormat:@"%@客服回复：\n%@",contentStr,solution];
    }
    
    cell.contentLabel.text = contentStr;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infoDic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *content = isNull(infoDic[@"opinion"][@"content"]) == YES ? @"" : infoDic[@"opinion"][@"content"];
    NSString *solution = isNull(infoDic[@"reply"][@"content"]) == YES ? @"" : infoDic[@"reply"][@"content"];
    NSString *contentStr = [NSString stringWithFormat:@"%@\n\n",content];
    if (!isNull(solution)) {
        contentStr = [NSString stringWithFormat:@"%@客服回复：\n%@",contentStr,solution];
    }
    CGFloat contentHeight = [NSString heightForString:contentStr labelWidth:self.frame.size.width - 40 fontOfSize:17];
    
    return 60 + contentHeight;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
