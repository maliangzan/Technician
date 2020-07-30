//
//  OrderListBaseViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/14.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderListBaseViewController.h"
#import "OrderDetailViewController.h"
#import "ServiceTimeViewController.h"
#import "OrdersCell.h"
#import "SYMyOrderListApi.h"
#import "AppDelegate.h"
#import <MJRefresh.h>
#import <MJRefreshStateHeader.h>

#define TITLE_VIEW_HEIGHT 40 * kHeightFactor
#define MIDLLE_VIEW_HEIGHT 30 * kHeightFactor

typedef NS_ENUM(NSInteger, MyOrderSortMethod) {//排序方法
    MyOrderSortByTheServiceTime = 0,//按照服务时间(默认)
    MyOrderSortByTheServiceType = 1,//上门时间按照服务项目类别
    
};

static NSString *orderCellID = @"OrdersCell";
@interface OrderListBaseViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,OrdersCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *emptyBtn;
@property (nonatomic,strong) NSMutableArray *myOrderList;
@property (nonatomic,assign) MyOrderSortMethod myOrderSortType;
@property (nonatomic,strong) UIButton *controlBtn;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) BOOL isUp;



@end

@implementation OrderListBaseViewController

- (instancetype)initWithOrderStadues:(SYOrderStadues)orderStadues{
    if ([super init]) {
        self.orderStadues = orderStadues;
        self.myOrderSortType = MyOrderSortByTheServiceTime;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObserveNotification(kNotificationSetOrderViewControllerClickServiceType, @selector(myOrderByType:));
    ObserveNotification(kNotificationSetOrderViewControllerClickServiceTime, @selector(myOrderByTime:));
    ObserveNotification(kNotificationServiceTimeViewControllerEndTimeSuccess, @selector(reloadData));
    ObserveNotification(kNotificationOrderListBaseViewControllerRefresh, @selector(reloadData));
    [self initData];
    [self loadData];
    [self setupUI];
    
}

- (void)initData{
    self.pageNum = 1;
    self.pageSize = 10;
    self.totalCount = 10;
    self.myOrderSortType = MyOrderSortByTheServiceTime;
    self.isUp = YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)myOrderByType:(NSNotification *)noty{
    UIButton *btn = (UIButton *)noty.object;
    self.controlBtn = btn;
    self.isUp = [[NSUserDefaults standardUserDefaults] boolForKey:isUpForMyOrderList];
    if (btn.selected) {
        self.myOrderSortType = MyOrderSortByTheServiceType;
    }
    [self loadData];
    
}

- (void)myOrderByTime:(NSNotification *)noty{
    UIButton *btn = (UIButton *)noty.object;
    self.controlBtn = btn;
    self.isUp = [[NSUserDefaults standardUserDefaults] boolForKey:isUpForMyOrderList];
    if (btn.selected) {
        self.myOrderSortType = MyOrderSortByTheServiceTime;
    }
    [self loadData];
}

- (void)reloadData{
    [self loadData];
}

- (void)loadData{
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }
    //请求我的订单列表
    BOOL arrayBool = NO;
    if (self.controlBtn) {
        arrayBool = self.controlBtn.selected;
    }
    
    NSString *myOrderBaseUrl = [NSString stringWithFormat:
                                @"%@dsSaleOrder/getTechnOrders?tid=%@&rank=%ld&array=%@&pageNo=%ld&pageSize=%ld",URL_HTTP_Base_Get,
                                [SYAppConfig shared].me.userID,//技师id
                                (long)self.myOrderSortType,//排序方法
                                [NSNumber numberWithBool:self.isUp],
                                (long)self.pageNum,
                                (long)self.pageSize
                                
                                ];
    NSString *myOrderUrl = myOrderBaseUrl;
    switch (self.orderStadues) {
        case SYOrderStaduesAll:
        {
        }
            break;
        case SYOrderStaduesToBeConfirmed:
        {
            myOrderUrl = [NSString stringWithFormat:@"%@&state=%@",myOrderBaseUrl,@"dqr"];
        }
            break;
        case SYOrderStaduesForThePayment:
        {
            myOrderUrl = [NSString stringWithFormat:@"%@&state=%@",myOrderBaseUrl,@"dfk"];
        }
            break;
        case SYOrderStaduesForTheService:
        {
            myOrderUrl = [NSString stringWithFormat:@"%@&state=%@",myOrderBaseUrl,@"dfw"];
        }
            break;
        case SYOrderStaduesComplete:
        {
            myOrderUrl = [NSString stringWithFormat:@"%@&state=%@",myOrderBaseUrl,@"ywc"];
            
        }
            break;
            
        default:
            break;
    }
    
    if (location) {
        myOrderUrl = [NSString stringWithFormat:@"%@&lng=%f&lat=%f",
                      myOrderUrl,
                      location.coordinate.longitude,
                      location.coordinate.latitude
                      ];
    }
    
    WeakSelf;
    [ProgressHUD show:Localized(@"拼命加载中，请稍后...")];
    SYMyOrderListApi *myOrderApi = [[SYMyOrderListApi alloc] initWithUrl:myOrderUrl];
    
    [myOrderApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [ProgressHUD dismiss];
        [weakself.view hideHUD];
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        NSDictionary *dictionary = request.responseObject;
        weakself.totalCount = [dictionary[@"totalCount"] integerValue];
        
        if (weakself.pageNum == 1) {
            [weakself.myOrderList removeAllObjects];
        }
        
        if (!isNullArray(request.responseObject[@"data"])) {
            for (NSDictionary *dic in request.responseObject[@"data"]) {
                SYNearbyOrderMode *orderMode = [SYNearbyOrderMode fromJSONDictionary:dic];
                [weakself.myOrderList addObject:orderMode];
            }
        }
        
        [weakself.tableView reloadData];
        if (weakself.myOrderList.count != 0) {
            [weakself.emptyBtn removeFromSuperview];
        }
        
    } failure:^(YTKBaseRequest *request) {
        weakself.pageNum = weakself.pageNum - 1;
        if (weakself.pageNum == 0) {
            weakself.pageNum = 1;
        }
        [ProgressHUD dismiss];
        [weakself.view hideHUD];
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"获取订单失败，连接不到服务器")];
        NSLog(@"%@", request.error);
    }];
    
}

#pragma mark method
- (void)setupUI{
    [self.view addSubview:self.tableView];
    if (self.myOrderList.count > 0) {
        [self.emptyBtn removeFromSuperview];
    }else{
        [self.tableView addSubview:self.emptyBtn];
    }
    
    WeakSelf;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 1;
        self.pageSize = 10;
        self.totalCount = 10;
        [weakself loadData];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSInteger maxPage = (weakself.totalCount / weakself.pageSize) + 1;
        
        weakself.pageNum = weakself.pageNum + 1;
        if (weakself.pageNum <= maxPage) {
            [weakself loadData];
        }else{
            weakself.pageNum = weakself.pageNum - 1;
            [weakself.view showHUDForInfo:Localized(@"数据已全部加载完成!")];
            [weakself.tableView.footer endRefreshing];
        }
        
    }];
}

- (void)addOrder:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *rootCtrl = (UITabBarController *)app.window.rootViewController;
    [rootCtrl setSelectedIndex:0];
}

- (void)configCell:(OrdersCell *)cell WithOrder:(SYOrderMode *)mode{
    if ([mode.state isEqualToString:@"dqr"]) {
        [self configButton:cell.startBtn withTitle:Localized(@"待确认") backgroungImage:@"btn_orange_n"];
    } else if([mode.state isEqualToString:@"dfk"]) {
        [self configButton:cell.startBtn withTitle:Localized(@"待付款") backgroungImage:@"btn_orange_n"];
    }else if([mode.state isEqualToString:@"dfw"]) {
        [self configButton:cell.startBtn withTitle:Localized(@"开始") backgroungImage:@"btn_orange_n"];
    }else if([mode.state isEqualToString:@"fwz"]) {
        [self configButton:cell.startBtn withTitle:Localized(@"服务中") backgroungImage:@"btn_orange_n"];
    }else if([mode.state isEqualToString:@"ywc"]) {
        [self configButton:cell.startBtn withTitle:Localized(@"已完成") backgroungImage:@"btn_gray_d"];
    }
    
}

- (void)configButton:(UIButton *)btn withTitle:(NSString *)title backgroungImage:(NSString *)imageName{
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setBackgroundImage:PNGIMAGE(imageName) forState:(UIControlStateNormal)];
}

#pragma mark OrdersCellDelegate
- (void)cliackStartBtnDQRAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"DQR"];
}
- (void)cliackStartBtnDFKAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"DFK"];
}

- (void)cliackStartBtnDFWAt:(OrdersCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SYNearbyOrderMode *nearbyMode = [self.myOrderList objectAtIndex:indexPath.row];
    [[SYAppConfig shared] startServiceTimeWithOrder:nearbyMode withSuperViewController:self];
}

- (void)cliackStartBtnFWZAt:(OrdersCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SYNearbyOrderMode *nearbyMode = [self.myOrderList objectAtIndex:indexPath.row];
    ServiceTimeViewController *vc = [[ServiceTimeViewController alloc] initWithMode:nearbyMode];
    [self.navigationController pushViewController:vc animated:YES];
    //    [self.view showHUDForError:@"FWZ"];
}

- (void)cliackStartBtnYWCAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"YWC"];
}

- (void)orderBtnClickAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"orderBtnClickAt"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myOrderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    SYNearbyOrderMode *mode = [self.myOrderList objectAtIndex:indexPath.row];
    [cell.bottomView removeFromSuperview];
    [cell configCellWithNearbyOrderMode:mode source:0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYNearbyOrderMode *mode = [self.myOrderList objectAtIndex:indexPath.row];
    SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:mode.sLocation];
    NSString *serviceAddressStr = [NSString stringWithFormat:@"%@",isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress];
    
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:mode.order];
    NSString *markStr = [NSString stringWithFormat:@"备注：%@",orderMode.otherRequirement];
    CGFloat servicePlaceTileLabelWidth = [NSString widthForString:@"服务地点：" labelHeight:15*kHeightFactor fontOfSize:12*kWidthFactor] + 3;
    
    return
    + 150.0*kHeightFactor
    - 20*kHeightFactor
    + [NSString heightForString:serviceAddressStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor - servicePlaceTileLabelWidth) fontOfSize:12*kWidthFactor]
    + [NSString heightForString:markStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor) fontOfSize:10*kWidthFactor];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYNearbyOrderMode *mode = [self.myOrderList objectAtIndex:indexPath.row];
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] initWithMyOrderListMode:mode];
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return PNGIMAGE(@"pic_nothing");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"喵～ 你从未飘过～\n555～  伦家已经哭倒在地了");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -120 * kHeightFactor;
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -  kCustomNavHeight - TITLE_VIEW_HEIGHT - MIDLLE_VIEW_HEIGHT) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource= self;
        _tableView.emptyDataSetDelegate  =self;
        [_tableView registerClass:[OrdersCell class] forCellReuseIdentifier:orderCellID];
        
    }
    return _tableView;
}

- (NSMutableArray *)myOrderList{
    if (!_myOrderList) {
        _myOrderList = [NSMutableArray array];
    }
    return _myOrderList;
}

- (UIButton *)emptyBtn{
    if (!_emptyBtn) {
        _emptyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _emptyBtn.frame = CGRectMake(KscreenWidth / 2 - 80, 220 * kHeightFactor, 160, 40);
        [_emptyBtn setTitleColor:kAppColorAuxiliaryDeepOrange forState:(UIControlStateNormal)];
        [_emptyBtn setTitle:Localized(@"现在看看>>") forState:(UIControlStateNormal)];
        [_emptyBtn addTarget:self action:@selector(addOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _emptyBtn;
}
@end
