//
//  NewsViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NewsViewController.h"
#import "NewMessageCell.h"
#import "SYGetMessageApi.h"
#import <MJRefresh.h>
#import "SYTimeHelper.h"

static NSString *messageCellID = @"NewMessageCell";

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic, strong)UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *userInfo;
@property (nonatomic,assign) BOOL isNotice;


@end

@implementation NewsViewController

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo isNoticeMessage:(BOOL)isNotice{
    if (self = [super init]) {
        self.userInfo = userInfo;
        self.isNotice = isNotice;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.isNotice) {
        [self loadData];
    } else {
        NSString *createTime = [SYTimeHelper niceDateFrom_YYYY_MM_DD_HH_mm:[NSDate date]];
        NSString *content = self.userInfo[@"aps"][@"alert"];
        content = isNull(content) ? @"":content;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:createTime forKey:@"createTime"];
        [dic setObject:content forKey:@"content"];
        [self.dataArray addObject:dic];
    }
    
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"消息";
    WeakSelf;
    self.leftBtn =^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };

    self.moreBtn.hidden = isNullArray(self.dataArray);
    self.bigRightButton.userInteractionEnabled = !isNullArray(self.dataArray);
    [self.moreBtn setTitle:Localized(@"清除") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [weakself showTips];
    };
    
    [self.view addSubview:self.tableView];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (!self.isNotice) {
            [weakself loadData];
        }
    }];
}

#pragma mark method
- (void)loadData{
    NSString *urlString = [NSString stringWithFormat:@"%@Health/app/dsNotice/queryList?",URL_HTTP_Base];
    WeakSelf;
    [self.view showHUDWithMessage:@""];
    SYGetMessageApi *api = [[SYGetMessageApi alloc] initWithUrl:urlString];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself.tableView.header endRefreshing];
        [weakself.view hideHUD];
        [weakself.dataArray removeAllObjects];
        for (NSDictionary *dic in request.responseObject[@"data"]) {
            [weakself.dataArray addObject:dic];
        }
        weakself.moreBtn.hidden = isNullArray(self.dataArray);
        weakself.bigRightButton.userInteractionEnabled = !isNullArray(self.dataArray);
        [weakself.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakself.tableView.header endRefreshing];
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
    }];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    if (!isNullDictionary(dic)) {
        cell.timeLabel.text = dic[@"createTime"];
        cell.messageLabel.text = dic[@"content"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isNullDictionary([self.dataArray objectAtIndex:indexPath.row])) {
        return 44;
    }
    NSString *message = [self.dataArray objectAtIndex:indexPath.row][@"content"];
    return 70 + [NSString heightForString:message labelWidth:KscreenWidth - 80 fontOfSize:15];
}
#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return PNGIMAGE(@"cf-message-empty");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无消息");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}

#pragma mark method


#pragma mark 清除
- (void)clearMessage{
    [self.dataArray removeAllObjects];
    self.moreBtn.hidden = !self.dataArray.count;
    self.bigRightButton.userInteractionEnabled = !isNullArray(self.dataArray);
    [self.tableView reloadData];
}

- (void)showTips{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"提示"), Localized(@"是否确认清空所有的消息?"), Localized(@"取消"), Localized(@"确认"))
      setCompleteBlock:^(UIAlertView *alertView, NSInteger index){
          if (index == 1) {
              [weakself clearMessage];
          }
      }] show];
}


#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        //这行代码必须加上，可以去除tableView的多余的线，否则会影响美观
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:messageCellID bundle:nil] forCellReuseIdentifier:messageCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark test
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = PNGIMAGE(@"test1");
    }
    return _imageView;
}

- (void)testView{
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
    }];

}

@end
