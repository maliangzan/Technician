//
//  SYListContenView.m
//  Technician
//
//  Created by TianQian on 2017/5/6.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "SYListContenView.h"
#import "DeviceNameCell.h"

static NSString *cellID = @"DeviceNameCell";
@implementation SYListContenView
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - private method


#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceNameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [item objectForKey:@"advertisementData"];
    NSNumber *RSSI = [item objectForKey:@"RSSI"];

    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }else{
        peripheralName = [peripheral.identifier UUIDString];
    }
    
    cell.titleLabel.text = peripheralName;
    //信号和服务
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",RSSI];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectedAtIndexPath:indexPath];
    [self close];
}
#pragma mark - empty-table DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    
//    return PNGIMAGE(@"cf-message-empty");
//}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"没有搜索到设备");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return -50 * kHeightFactor;
//}

#pragma mark SYListContenViewDelegate
- (void)closeTips{
    [self removeFromSuperview];
}

- (IBAction)colseBtnAction:(UIButton *)sender {
    [self close];
}

- (void)close{
    [self.delegate closeTips];
}

#pragma mark get
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
