//
//  SYServiceAddressMapBackView.m
//  Technician
//
//  Created by TianQian on 2017/5/18.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYServiceAddressMapBackView.h"
#import "SYAddressSelectCell.h"

static NSString *cellID = @"SYAddressSelectCell";
@implementation SYServiceAddressMapBackView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //获取searchBar里面的TextField
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    //更改searchBar输入文字颜色
    searchField.textColor= kAppColorTextMiddleBlack;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    
    [self createLeftViewReferTo:self.detailAddressTextFeild IconImgStr:@"inputsomething"];
    
    [self configSearchBar];
}

#pragma mark method
- (void)configSearchBar{
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit]; //自动调整大小
//    self.searchBar.showsCancelButton = YES;
    self.searchBar.barTintColor = kAppColorBackground;
}

- (void)createLeftViewReferTo:(UITextField *)textfield IconImgStr:(NSString *)name{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 19)];
    iconImg.image = PNGIMAGE(name);
    [leftView addSubview:iconImg];
    
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
}
#pragma mark UISearchBarDelegate
//点击键盘上得search按钮 开始调用此方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString * getStr = searchBar.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSearchAddressAction object:getStr];
    //让键盘失去第一响应者
    [searchBar resignFirstResponder];
}

//此方法实时监测搜索框中文本变化
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString * getStr = searchBar.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSearchAddressAction object:getStr];

}
//点击搜索框行的cancel按钮调用此方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];

}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYAddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectBtn.hidden = YES;
    [cell configCellWithDictionay:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYAddressSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.hidden = NO;
    [self.delegate selectedAddressAtIndexPath:indexPath];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
//    NSString *address = [NSString stringWithFormat:@"%@%@",dic[@"title"],dic[@"subtitle"]];
    NSString *address = [NSString stringWithFormat:@"%@",dic[@"subtitle"]];
    self.searchBar.text = address;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYAddressSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
}

#pragma mark <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    //    return PNGIMAGE(@"cf-message-empty");
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无地址");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}

#pragma mark get


@end
