//
//  FeedbackRecordViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/13.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "FeedbackRecordViewController.h"
#import "FeedbackRecordCell.h"
#import "CustomTipsSheet.h"

static NSString *feedbackCellID = @"FeedbackRecordCell";
@interface FeedbackRecordViewController ()<UITableViewDelegate,UITableViewDataSource,FeedbackRecordCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation FeedbackRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"反馈记录";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark FeedbackRecordCellDelegate
- (void)showFeedBackDetailAtCell:(FeedbackRecordCell *)cell{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WeakSelf;
    CustomTipsSheet *detailPicker = [[CustomTipsSheet alloc] initWithFrame:self.view.bounds tipType:SYTipTypeFeedback title:Localized(@"") contenViewHeight:KscreenHeight / 2 + 40];
    detailPicker.pickerDone = ^(NSString *selectedStr) {
    };
    [self.view addSubview:detailPicker];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedbackRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:feedbackCellID];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:feedbackCellID bundle:nil] forCellReuseIdentifier:feedbackCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    }
    return _dataArray;
}

@end
