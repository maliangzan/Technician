//
//  AboutUsBackView.m
//  Technician
//
//  Created by TianQian on 2017/4/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "AboutUsBackView.h"
#import "OnlyOneLabelCell.h"

static NSString *oneLabelCellID = @"OnlyOneLabelCell";
@implementation AboutUsBackView
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:oneLabelCellID bundle:nil] forCellReuseIdentifier:oneLabelCellID];
}

#pragma mark method
- (NSAttributedString *)gettingAttributedStringWith:(NSString *)string{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kAppColorAuxiliaryLightOrange range:NSMakeRange(string.length - 12, 12)];
    return attrStr;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnlyOneLabelCell *cell=[tableView dequeueReusableCellWithIdentifier:oneLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell==nil){
        cell=[[OnlyOneLabelCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:oneLabelCellID];
    }
    if (indexPath.row == 0) {
        cell.contentLabel.attributedText = [self gettingAttributedStringWith:[self.dataArray objectAtIndex:indexPath.row]];
    }else{
        cell.contentLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CallWithPhoneNumber(@"400-800-4016");
    }
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[
                                                      @"客服热线：400-800-4016",
                                                      @"邮箱：sayes800@sayesmed.com",
                                                      @"网址：www.sayesmed.com",
                                                      @"地址：深圳市龙华新区光辉科技园2栋2层"]];
    }
    return _dataArray;
}

@end
