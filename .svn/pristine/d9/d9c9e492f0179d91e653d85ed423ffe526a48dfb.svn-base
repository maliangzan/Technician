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
#import "SYCustomServiceApi.h"
#import "SYNewFeedBackRecordApi.h"

static NSString *feedbackCellID = @"FeedbackRecordCell";
@interface FeedbackRecordViewController ()<UITableViewDelegate,UITableViewDataSource,FeedbackRecordCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation FeedbackRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
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

- (void)loadData{
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    [[[SYNewFeedBackRecordApi alloc] initWithSource:@"technician"]
     startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
         [[UIApplication sharedApplication].keyWindow hideHUD];
         [weakself.view hideHUD];
         if ([request isSuccess]) {
             [weakself.view hideHUD];
             if (!isNullDictionary(request.responseObject[@"data"])) {
                 [weakself.dataArray removeAllObjects];
                 for (NSDictionary *dic in request.responseObject[@"data"][@"Vo"]) {
                     [self.dataArray addObject:dic];
                 }
                 [weakself.tableView reloadData];
             }
             
             
         } else if ([request isCommonErrorAndHandle]) {
             return ;
         } else {
             [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
         }
     } failure:^(YTKBaseRequest *request) {
         [weakself.view hideHUD];
         [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
         NSLog(@"%@", request.error);
     }];
}

#pragma mark FeedbackRecordCellDelegate
- (void)showFeedBackDetailAtCell:(FeedbackRecordCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *userDic = [self.dataArray objectAtIndex:indexPath.row];
    
    CGFloat contentHeight = [NSString heightForString:userDic[@"opinion"][@"content"] labelWidth:KscreenWidth - 80 fontOfSize:17];
    CGFloat solutionHeight = [NSString heightForString:userDic[@"reply"][@"content"] labelWidth:KscreenWidth - 80 fontOfSize:17];
    CGFloat detailPickerHeight = 80 + 20 + 90 + contentHeight + solutionHeight;
    detailPickerHeight = (detailPickerHeight > KscreenHeight / 2 + 40) ? (KscreenHeight / 2 + 40):detailPickerHeight;
    
    CustomTipsSheet *detailPicker = [[CustomTipsSheet alloc] initWithFrame:self.view.bounds tipType:SYTipTypeFeedback title:Localized(@"") contenViewHeight:detailPickerHeight userInfo:userDic];
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
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    cell.resonLabel.text = isNull(dic[@"opinion"][@"content"]) == YES ? @"":dic[@"opinion"][@"content"];
    cell.timeLabel.text = isNull(dic[@"opinion"][@"createTime"]) == YES ?@"":dic[@"opinion"][@"createTime"];
    if (isNull(dic[@"reply"][@"content"])) {
        cell.staduesLabel.text = Localized(@"待处理");
    }else{
        cell.staduesLabel.text = Localized(@"已处理");
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [_tableView registerNib:[UINib nibWithNibName:feedbackCellID bundle:nil] forCellReuseIdentifier:feedbackCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
