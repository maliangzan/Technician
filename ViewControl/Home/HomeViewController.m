//
//  HomeViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "HomeViewController.h"
#import "OCHomeHeaderView.h"
#import "OrdersCell.h"
#import "ServiceTimeViewController.h"
#import "SetOrderViewController.h"
#import "SYHomeTableView.h"
#import "NewsViewController.h"
#import "LoginViewController.h"
#import "EditDataStepOneViewController.h"
#import "SYMyOrderListApi.h"
#import "SYHomeSectionHeadView.h"
#import "SYServiceOrderApi.h"
#import "SYTheNewOrderCell.h"
#import "SetOrderViewController.h"
#import "AppDelegate.h"
#import "OrderDetailViewController.h"
#import "ServiceDetailsViewController.h"
#import "SYActionSheet.h"
#import "SYGrabASingleApi.h"
#import "SYStartServiceApi.h"
#import "SYEarningApi.h"
#import "EarningMode.h"
#import "DateValueFormatter.h"
#import "DailyEarningMode.h"
#import "SYTimeHelper.h"
#import "SYUploadWorkingStadusApi.h"
#import <MJRefresh.h>
//#import "BalloonMarker.swift"
@import Charts;


static NSString *orderCellID = @"OrdersCell";
static NSString *theNewOrderCellID = @"SYTheNewOrderCell";
#define TABLE_VIEW_HEAD_HEIGHT 400

#define DEFAULT_LATITUDE 0.000000
#define DEFAULT_LONGITUDE 0.000000

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,OrdersCellDelegate,SYHomeSectionHeadViewDelegate,ChartViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *noticeBtn;
@property(nonatomic, strong)UIButton *ordersBtn;
@property (nonatomic,strong) SYHomeTableView *tableHeadView;
@property (nonatomic,strong) NSMutableArray *myOrderList;
@property (nonatomic,strong) NSMutableArray *theNewOrderArray;
@property (nonatomic,strong) NSMutableArray *earingCount;
@property (nonatomic,strong) EarningMode *earningMode;
@property (nonatomic, strong) LineChartView *chartView;
@property (nonatomic,assign) double maxIncomeValue;
@property (nonatomic,strong) SYNearbyOrderMode *testOrder;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindData];
    ObserveNotification(kNotificationHomeViewControllerLoadData, @selector(loadData));
    ObserveNotification(kNotificationLoginSuccess, @selector(loadData));
    ObserveNotification(kNotificationLoginSuccess, @selector(configOrderBtnState));
    ObserveNotification(kNotificationChangeOrderState, @selector(changeOrderState));
    
    //如果用户没有选择自动登录，即使AppDelegate登录成功，也要去到登录界面
    BOOL isRememberThePassword = [[NSUserDefaults standardUserDefaults] boolForKey:rememberThePasswordKey];
    if (!isRememberThePassword) {
        [[SYAppConfig shared] gotoLoginViewController];
    }
    
    if ([SYAppConfig shared].me.hasLogin) {
        [self loadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    WeakSelf;
    [[SYAppConfig shared] loadTheUnionStateWithSuccessBlock:^(id responseObject) {
        [weakself canTips];
    } failureBlock:^(id error) {
        
    }];
}

- (void)canTips{
    if ([SYAppConfig shared].me.hasLogin && ![SYAppConfig shared].me.hasJoinIn) {
        [self tipsUnion];
    }
}

- (void)tipsUnion{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"登录成功"), Localized(@"加入我们，立即马上接单赚取收入，是否现在就加入？"), Localized(@"我先看看"), Localized(@"马上加盟")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            EditDataStepOneViewController *vc = [[EditDataStepOneViewController alloc] init];
            self.tabBarController.tabBar.hidden = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    }] show];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:self.noticeBtn];
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView).offset(20*kWidthFactor);
        make.top.equalTo(self.tableView).offset(40*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(17*kWidthFactor, 25*kHeightFactor));
    }];
    
    [self.tableView addSubview:self.ordersBtn];
    [self.ordersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView).offset(KscreenWidth - 50*kWidthFactor);
        make.top.equalTo(self.tableView).offset(40*kHeightFactor);
        make.size.mas_equalTo(CGSizeMake(43*kWidthFactor, 27*kHeightFactor));
    }];
    
    WeakSelf;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.pageNum = 1;
        [weakself loadData];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.pageNum = 1;
        [weakself loadData];
//        NSInteger maxPage = weakself.totalCount / weakself.pageSize + 1;
//        
//        weakself.pageNum = weakself.pageNum + 1;
//        if (weakself.pageNum < maxPage) {
//            [weakself loadData];
//        }else{
//            weakself.pageNum = weakself.pageNum - 1;
//            [weakself.view showHUDForInfo:Localized(@"数据已全部加载完成!")];
//            [weakself.tableView.footer endRefreshing];
//        }
        
    }];
    
}

#pragma mark method
- (void)configOrderBtnState{
    if ([[SYAppConfig shared].me.state isEqualToString:@"jdz"]) {
        [self.ordersBtn setBackgroundImage:PNGIMAGE(@"intheorder") forState:UIControlStateNormal];
    } else {
        [self.ordersBtn setBackgroundImage:PNGIMAGE(@"intherest") forState:(UIControlStateNormal)];
    }
}

- (void)changeOrderState{
    [self configOrderBtnState];
}

- (void)bindData{
    self.pageNum = 1;
    self.pageSize = 10;
    self.totalCount = 10;
}

- (void)loadData{
    //收入数据汇总
    [self loadTheIncomeData];
    
    //请求我的订单列表
    [self loadMyOrderList];
    
    //请求最新订单列表
    [self loadTheNewOrderList];
}

- (void)tipsOpenLocationAction{
    [[SYAppConfig shared] tipsOpenLocation];
}

- (void)loadTheIncomeData{
    WeakSelf;
    NSString *earningStr = [NSString stringWithFormat:
                            @"%@dsTechnicianEarning/sumEarning?tid=%@",
                            URL_HTTP_Base_Get,
                            [SYAppConfig shared].me.userID
                            ];
    SYEarningApi *earningApi = [[SYEarningApi alloc] initWithUrl:earningStr];
    
    [earningApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.earingCount removeAllObjects];
        weakself.earningMode = [EarningMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself.earingCount addObjectsFromArray:weakself.earningMode.earingCount];
        if (!isNullArray(weakself.earingCount)) {
            [weakself configTableHeadView];
            [weakself.tableView reloadData];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
    
}

- (void)configTableHeadView{
    //总金额
    CGFloat totlePrice = [[self.earingCount lastObject] floatValue] / 100;
    
    self.tableHeadView.theAmountOfLabel.text = [NSString stringWithFormat:@"%.2f",totlePrice];
    
    //今日收入
    CGFloat todayIncome = [[self.earingCount firstObject] floatValue] / 100;
    self.tableHeadView.dayIncomeLabel.text = [NSString stringWithFormat:@"%.2f",todayIncome];
    
    //本周收入
    CGFloat weakIncome = [[self.earingCount objectAtIndex:1] floatValue] / 100;
    self.tableHeadView.weekIncomeLabel.text = [NSString stringWithFormat:@"%.2f",weakIncome];
    
    //本月收入
    CGFloat mouthIncome = [[self.earingCount objectAtIndex:2] floatValue] / 100;
    self.tableHeadView.mouthIncomeLabel.text = [NSString stringWithFormat:@"%.2f",mouthIncome];
    
    //图表
    NSMutableArray *yDataArray = [NSMutableArray array];
    NSMutableArray *xDataArray = [NSMutableArray array];
    if (self.earningMode.dailyEarnings.count > 0) {
        for (NSDictionary *dic in self.earningMode.dailyEarnings) {
            DailyEarningMode *dailyEarningMode = [DailyEarningMode fromJSONDictionary:dic];
            double dailyEarning = [dailyEarningMode.dailyEarning doubleValue] / 100.00;
            if (dailyEarning > self.maxIncomeValue) {
                self.maxIncomeValue = dailyEarning;
            }
            NSString *yStr = [NSString stringWithFormat:@"%.2f",([dailyEarningMode.dailyEarning doubleValue]) / 100.00];
            [yDataArray addObject:isNull(yStr) == YES ? @"":yStr];
            NSString *xStr = [dailyEarningMode.date stringValue];
            [xDataArray addObject:isNull(xStr) == YES ? @"":xStr];
        }
    } else {
        for (int i = 0 ; i < 1 ; i++) {
            NSString *yStr = [NSString stringWithFormat:@"%.2f",0.0];
            [yDataArray addObject:yStr];
            NSString *xStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:[NSDate date]];
            [xDataArray addObject:xStr];
        }
    }
    
    //设置y轴的最大值
    if (self.maxIncomeValue > 10) {
        self.chartView.leftAxis.axisMaximum = self.maxIncomeValue + 10.00;
    }else if (self.maxIncomeValue > 100){
        self.chartView.leftAxis.axisMaximum = self.maxIncomeValue + 100.00;
    }else if (self.maxIncomeValue > 1000){
        self.chartView.leftAxis.axisMaximum = self.maxIncomeValue + 1000.00;
    }else{
        self.chartView.leftAxis.axisMaximum = self.maxIncomeValue + 1.00;
    }
    if (!isNullArray(yDataArray) && !isNullArray(xDataArray)) {
        [self setdataArr:yDataArray andDate:xDataArray];
    }
    //testData
//    [self setdataArr:@[@"210.23",@"320.47",@"120.47",@"220.47",@"420.47"] andDate:xDataArray];
    
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleFilled"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCircles"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawCirclesEnabled = !set.isDrawCirclesEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeLinear : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleStepped"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawSteppedEnabled = !set.isDrawSteppedEnabled;
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHorizontalCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeHorizontalBezier : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    //    [super handleOption:key forChartView:_chartView];
}

- (void)loadMyOrderList{
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }
    
    WeakSelf;
    NSString *myOrderurlStr = [NSString stringWithFormat:
                               @"%@dsSaleOrder/getTechnOrders?tid=%@&rank=0&array=1",
                               URL_HTTP_Base_Get,[SYAppConfig shared].me.userID
                               
                               ];
    if (location) {
        myOrderurlStr = [NSString stringWithFormat:@"%@&lng=%f&lat=%f",
                         myOrderurlStr,
                         location.coordinate.longitude,
                         location.coordinate.latitude
                         ];
    }
    SYMyOrderListApi *myOrderApi = [[SYMyOrderListApi alloc] initWithUrl:myOrderurlStr];
    
    [myOrderApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.myOrderList removeAllObjects];
        if (!isNullArray(request.responseObject[@"data"])) {
            for (NSDictionary *dic in request.responseObject[@"data"]) {
                SYNearbyOrderMode *orderMode = [SYNearbyOrderMode fromJSONDictionary:dic];
//                NSLog(@"%@\n",orderMode.order);
                [weakself.myOrderList addObject:orderMode];
            }
        }
        
        [weakself.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        
        NSLog(@"%@", request.error);
    }];
}

- (void)loadTheNewOrderList{
    if (([SYAppConfig shared].me.currentLocation.coordinate.latitude == DEFAULT_LATITUDE && [SYAppConfig shared].me.currentLocation.coordinate.longitude == DEFAULT_LONGITUDE) && ![SYAppConfig shared].me.changeLocation) {
        
        if ([[SYAppConfig shared] isOpenLocationService]) {
            [[SYAppConfig shared] startLocation];
            [self.view showHUDForError:Localized(@"正在获取您的位置信息，请稍后...")];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        } else {
            [self.view hideHUD];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            [self tipsOpenLocationAction];
        }
        return;
    }
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/getLatestOrders.do?tid=%@&lng=%f&lat=%f&pageNo=%ld&pageSize=%ld",URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        location.coordinate.longitude,//经度
                        location.coordinate.latitude,//纬度
                        (long)self.pageNum,
                        (long)self.pageSize
                        ];
    SYServiceOrderApi *api = [[SYServiceOrderApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        if (weakself.pageNum == 1) {
            [weakself.theNewOrderArray removeAllObjects];
        }
        
        weakself.totalCount = [request.responseObject[@"data"][@"totalCount"] integerValue];
        for (NSDictionary *dic in [request.responseObject[@"data"] objectForKey:@"nearbyOrders"]) {
            SYNearbyOrderMode *nearbyMode = [SYNearbyOrderMode fromJSONDictionary:dic];
            [weakself.theNewOrderArray addObject:nearbyMode];
        }
        //        [weakself.theNewOrderArray addObject:self.testOrder];
        [weakself.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        NSLog(@"%@", request.error);
    }];
}

- (void)changeWorkingStadues:(UIButton *)btn{
    SYActionSheet *staduesPicker = [[SYActionSheet alloc] initWithFrame:self.view.bounds];
    staduesPicker.dataArray = [NSMutableArray arrayWithArray:@[@[@"接单中",@"休息中"]]];
    WeakSelf;
    staduesPicker.pickerDone = ^(NSString *selectedStr) {
        [weakself uploadWorkingStaduesWithString:selectedStr];
    };
    [self.view addSubview:staduesPicker];
}

- (void)uploadWorkingStaduesWithString:(NSString *)string{
    NSString *stateString;
    if ([string isEqualToString:@"接单中"]) {
        stateString = @"jdz";
    } else {
        stateString = @"xxz";
    }
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsTechnician/iu?id=%@&state=%@",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        stateString
                        ];
    urlStr = [urlStr urlNSUTF8StringEncoding];
    WeakSelf;
    SYUploadWorkingStadusApi *api = [[SYUploadWorkingStadusApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        if ([string isEqualToString:@"接单中"]) {
            [weakself.ordersBtn setBackgroundImage:PNGIMAGE(@"intheorder") forState:(UIControlStateNormal)];
        } else {
            [weakself.ordersBtn setBackgroundImage:PNGIMAGE(@"intherest") forState:(UIControlStateNormal)];
        }
        [SYAppConfig shared].me.state = stateString;
        PostNotificationWithName(kNotificationChangeOrderState);
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"修改失败，连接不到服务器")];
        NSLog(@"%@", request.error);
    }];
    
}

- (void)goToMyOrderAtIndex:(NSInteger)index{
    SetOrderViewController *orderVC = [[SetOrderViewController alloc] init];
    orderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)noticeBtnAction:(UIButton *)btn{
    NewsViewController *newsVC = [[NewsViewController alloc] initWithUserInfo:nil isNoticeMessage:NO];
    newsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (void)lookAllMyOrder{
    SetOrderViewController *vc = [[SetOrderViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)lookTheNewOrder{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *rootCtrl = (UITabBarController *)app.window.rootViewController;
    [rootCtrl setSelectedIndex:1];
}

- (void)showHintView{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"已成功接单"), Localized(@"请及时安排好上门时间。出门前请务必提前和客户电话确认。\n祝您工作愉快"), Localized(@"取消"), Localized(@"查看订单")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            [weakself goToMyOrderAtIndex:0];
        }
    }] show];
}

- (void)showFaildView{
    [self.view showHUDForError:Localized(@"抢单失败！")];
}

#pragma mark OrdersCellDelegate
- (void)cliackStartBtnDQRAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"DQR"];
}
- (void)cliackStartBtnDFKAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"DFK"];
}

- (void)cliackStartBtnDFWAt:(OrdersCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    if (indexP.section == 0) {
        SYNearbyOrderMode *nearbyMode = [self.myOrderList objectAtIndex:indexP.row];
        [[SYAppConfig shared] startServiceTimeWithOrder:nearbyMode withSuperViewController:self];
    }
}

- (void)cliackStartBtnFWZAt:(OrdersCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    if (indexP.section == 0) {
        SYNearbyOrderMode *nearbyMode = [self.myOrderList objectAtIndex:indexP.row];
        ServiceTimeViewController *vc = [[ServiceTimeViewController alloc] initWithMode:nearbyMode];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //    [self.view showHUDForError:@"FWZ"];
}

- (void)cliackStartBtnYWCAt:(OrdersCell *)cell{
    //    [self.view showHUDForError:@"YWC"];
}

- (void)orderBtnClickAt:(OrdersCell *)cell{
//    if (cell.bottomView.orderBtn.selected) {
//        return;
//    }
    
    if ([[SYAppConfig shared].me.state isEqualToString:@"xxz"]) {
        [self.view showHUDForError:Localized(@"休息中，暂不能接单！")];
        return;
    }
    
    WeakSelf;
    [[SYAppConfig shared] loadTheUnionStateWithSuccessBlock:^(id responseObject) {
        [weakself canOrderWithCell:cell];
    } failureBlock:^(id error) {
        
    }];
}

- (void)canOrderWithCell:(OrdersCell *)cell{
    
    if (![[SYAppConfig shared].me.stateEvaluation isEqualToString:@"ytg"]) {
        [self.view showHUDForError:Localized(@"加盟通过后才能接单哦！")];
        return;
    }
    
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    SYNearbyOrderMode *nearbyMode = [self.theNewOrderArray objectAtIndex:indexP.row];
    SYOrderMode *order = [SYOrderMode fromJSONDictionary:nearbyMode.order];
    
    WeakSelf;
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/scrambleOrder?tid=%@&oid=%@",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        order.orderID//oid
                        ];
    [[UIApplication sharedApplication].keyWindow showHUDWithMessage:Localized(@"")];
    SYGrabASingleApi *api = [[SYGrabASingleApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
//        cell.bottomView.orderBtn.selected = YES;
        
        if ([request.responseObject[@"response"] boolValue]) {
            
            NSInteger code = [request.responseObject[@"code"] integerValue];
            switch (code) {
                case 0:
                {
                    [cell.bottomView.orderBtn setImage:PNGIMAGE(@"has_order") forState:(UIControlStateNormal)];
                    [weakself showHintView];
                    PostNotificationWithName(kNotificationHomeViewControllerLoadData);
                    PostNotificationWithName(kNotificationOrdersViewControllerRefresh);
                }
                    break;
                default:
                    [weakself.view showHUDForError:request.responseObject[@"message"]];
                    break;
            }
        } else {
            [weakself.view showHUDForError:request.responseObject[@"message"]];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

#pragma mark SYHomeSectionHeadViewDelegate
- (void)loockMoreAt:(SYHomeSectionHeadView *)headView{
    if (headView.tag == 100) {
        //查看我的订单
        [self lookAllMyOrder];
    }else if (headView.tag == 101){
        //查看最新订单
        [self lookTheNewOrder];
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return self.myOrderList.count == 0 ? 0:1;
        }
            break;
        case 1:
        {
            return self.theNewOrderArray.count > 3 ? 3:self.theNewOrderArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
    return self.myOrderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //我的订单
        OrdersCell * orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        orderCell.delegate = self;
        
        SYNearbyOrderMode *mode = [self.myOrderList objectAtIndex:indexPath.row];
        orderCell.bottomView.hidden = YES;
        orderCell.sourceOfOrderBtn.hidden = YES;
        [orderCell configCellWithNearbyOrderMode:mode source:0];
        return orderCell;
    }else if(indexPath.section == 1){
        //最新订单
        SYTheNewOrderCell *theNewOrdercell = [tableView dequeueReusableCellWithIdentifier:theNewOrderCellID];
        theNewOrdercell.selectionStyle = UITableViewCellSelectionStyleNone;
        theNewOrdercell.delegate = self;
        SYNearbyOrderMode *nearbyOrder = [self.theNewOrderArray objectAtIndex:indexPath.row];
        [theNewOrdercell configCellWithNearbyOrderMode:nearbyOrder source:1];
        return theNewOrdercell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SYNearbyOrderMode *nearbyOrderMode = [self.myOrderList objectAtIndex:0];
        //查看订单详情
        OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithMyOrderListMode:nearbyOrderMode];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else if (indexPath.section == 1) {
        //查看服务详情
        SYNearbyOrderMode *nearbyOrder = [self.theNewOrderArray objectAtIndex:indexPath.row];
        ServiceDetailsViewController *detailVC = [ServiceDetailsViewController new];
        detailVC.orderListMode = nearbyOrder;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SYNearbyOrderMode *mode = [self.myOrderList objectAtIndex:indexPath.row];
        SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:mode.sLocation];
        SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:mode.serviceInfo];
        NSString *serviceAddressStr = [NSString stringWithFormat:@"%@",isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress];
        
        SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:mode.order];
        NSString *titleStr = [NSString stringWithFormat:@"%@   (%@分钟)",isNull(serviceInfoMode.name) == YES ? @"":serviceInfoMode.name,isNull([serviceInfoMode.serviceTotalTime stringValue]) == YES ? @"0":serviceInfoMode.serviceTotalTime];
        NSString *markStr = [NSString stringWithFormat:@"备注：%@",orderMode.otherRequirement];
        CGFloat servicePlaceTileLabelWidth = [NSString widthForString:@"服务地点：" labelHeight:15*kHeightFactor fontOfSize:12*kWidthFactor] + 3;
        
        return
        + 130.0*kHeightFactor
        - 20*kHeightFactor
        + [NSString heightForString:serviceAddressStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor - servicePlaceTileLabelWidth) fontOfSize:12*kWidthFactor]
        + [NSString heightForString:markStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor) fontOfSize:10*kWidthFactor]
        + [NSString heightForString:titleStr labelWidth:(KscreenWidth - 20*kWidthFactor - 65*kWidthFactor - 55*kWidthFactor) fontOfSize:12*kWidthFactor];
    }
    
    SYNearbyOrderMode *nearbyOrder = [self.theNewOrderArray objectAtIndex:indexPath.row];
    SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:nearbyOrder.sLocation];
    NSString *serviceAddressStr = [NSString stringWithFormat:@"%@",isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress];
    
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:nearbyOrder.order];
    SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:nearbyOrder.serviceInfo];
    NSString *markStr = [NSString stringWithFormat:@"备注：%@",orderMode.otherRequirement];
    NSString *titleStr = [NSString stringWithFormat:@"%@   (%@分钟)",isNull(serviceInfoMode.name) == YES ? @"":serviceInfoMode.name,isNull([serviceInfoMode.serviceTotalTime stringValue]) == YES ? @"0":serviceInfoMode.serviceTotalTime];
    CGFloat servicePlaceTileLabelWidth = [NSString widthForString:@"服务地点：" labelHeight:15*kHeightFactor fontOfSize:12*kWidthFactor] + 3;
    
    return
    + 150.0*kHeightFactor
    - 20*kHeightFactor
    + [NSString heightForString:serviceAddressStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor - servicePlaceTileLabelWidth) fontOfSize:12*kWidthFactor]
    + [NSString heightForString:markStr labelWidth:(KscreenWidth - 55*kWidthFactor - 20*kWidthFactor - 8*kWidthFactor) fontOfSize:10*kWidthFactor]
    + [NSString heightForString:titleStr labelWidth:(KscreenWidth - 20*kWidthFactor - 65*kWidthFactor - 55*kWidthFactor) fontOfSize:12*kWidthFactor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYHomeSectionHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"SYHomeSectionHeadView" owner:nil options:nil] objectAtIndex:0];
    headView.frame = CGRectMake(0, 0, KscreenWidth, 50);
    headView.tag = 100 + section;
    headView.delegate = self;
    if (section == 0) {
        headView.titleLabel.text = Localized(@"我的订单");
    }else{
        headView.titleLabel.text = Localized(@"最新订单");
    }
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

#pragma mark 懒加载
- (SYHomeTableView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[[NSBundle mainBundle] loadNibNamed:@"SYHomeTableView" owner:nil options:nil] objectAtIndex:0];
        _tableHeadView.frame = CGRectMake(0, 0, KscreenWidth, TABLE_VIEW_HEAD_HEIGHT);
        self.maxIncomeValue = 0.01;
        [_tableHeadView.tableBgView addSubview:self.chartView];
        
    }
    return _tableHeadView;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight - 49);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.tableHeadView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[OrdersCell class] forCellReuseIdentifier:orderCellID];
        [self.tableView registerClass:[SYTheNewOrderCell class] forCellReuseIdentifier:theNewOrderCellID];
    }
    return _tableView;
}

-(UIButton *)noticeBtn{
    if (!_noticeBtn) {
        _noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noticeBtn setBackgroundImage:PNGIMAGE(@"home_notice_btn") forState:UIControlStateNormal];
        [_noticeBtn addTarget:self action:@selector(noticeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _noticeBtn;
}

-(UIButton *)ordersBtn{
    if (!_ordersBtn) {
        _ordersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self configOrderBtnState];
        [_ordersBtn addTarget:self action:@selector(changeWorkingStadues:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _ordersBtn;
}

- (NSMutableArray *)myOrderList{
    if (!_myOrderList) {
        _myOrderList = [NSMutableArray array];
    }
    return _myOrderList;
}

- (NSMutableArray *)theNewOrderArray{
    if (!_theNewOrderArray) {
        _theNewOrderArray = [NSMutableArray array];
    }
    return _theNewOrderArray;
}

- (NSMutableArray *)earingCount{
    if (!_earingCount) {
        _earingCount = [NSMutableArray array];
    }
    return _earingCount;
}

- (SYNearbyOrderMode *)testOrder{
    
    if (!_testOrder) {
        _testOrder = [[SYNearbyOrderMode alloc] init];
        _testOrder.distance = @100;
        _testOrder.order = @{@"appointServiceTime":@"2017-08-09 15:09:00",@"otherRequirement":@"客户端发单"};
        _testOrder.sLocation = @{@"address":@"设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面"};
    }
    return _testOrder;
}

- (LineChartView *)chartView{
    if (!_chartView) {
        CGFloat chartScrollviewX = 0;
        CGFloat chartScrollviewY = 0;
        CGFloat chartScrollviewW = KscreenWidth;
        CGFloat chartScrollviewH = 195;
        _chartView = [[LineChartView alloc]initWithFrame:CGRectMake(chartScrollviewX, chartScrollviewY, chartScrollviewW - 10, chartScrollviewH)];
        _chartView.delegate = self;
        _chartView.chartDescription.enabled = NO;
        _chartView.dragEnabled = YES;
        [_chartView setScaleEnabled:YES];
        _chartView.drawGridBackgroundEnabled = NO;
        _chartView.pinchZoomEnabled = YES;

//        [_chartView zoomWithScaleX:1.03 scaleY:1 x:0 y:0];
        _chartView.xAxis.granularity = 1.0;
        //    _chartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
        //        _chartView.backgroundColor = [UIColor whiteColor];
        
        ChartLegend *l = _chartView.legend;
        l.form = ChartLegendFormLine;
        l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        l.textColor = kAppColorTextMiddleBlack;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        l.orientation = ChartLegendOrientationHorizontal;
        //    l.drawInside = NO;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelFont = [UIFont systemFontOfSize:11.f];
        xAxis.labelTextColor = kAppColorTextMiddleBlack;
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelCount = 3;
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelTextColor = kAppColorTextMiddleBlack;
        leftAxis.axisMaximum = self.maxIncomeValue;
        leftAxis.labelCount = 6;
        leftAxis.axisMinimum = 0.0;
        leftAxis.drawGridLinesEnabled = YES;
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        leftAxis.granularityEnabled = YES;
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.labelTextColor = kAppColorTextMiddleBlack;
        rightAxis.drawLabelsEnabled = NO;
        rightAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.granularityEnabled = NO;
        rightAxis.labelCount = 0;
        //    rightAxis.enabled = NO;
        
//        ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:78 label:@""];
//        limitLine.lineWidth = 1;
//        limitLine.lineColor = [UIColor orangeColor];
//        limitLine.lineDashLengths = @[@0.0f, @0.0f];//虚线样式
//        limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
//        [leftAxis addLimitLine:limitLine];//添加到Y轴上
//        leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在后面
//        [_chartView setDescriptionText:@""];
//        [_chartView animateWithXAxisDuration:1.5];
        
        [self.view addSubview:_chartView];
        BalloonMarker *marker = [[BalloonMarker alloc]
                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                 font: [UIFont systemFontOfSize:12.0]
                                 textColor: UIColor.whiteColor
                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = _chartView;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        _chartView.marker = marker;
        
        _chartView.legend.form = ChartLegendFormLine;
    }
    return _chartView;
}


-(void)setdataArr:(NSArray *)arr andDate:(NSArray *)dateArr{
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0;i < arr.count; i ++) {
        
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:[arr[i]doubleValue]]];
        
        
    }
    
        if (self.earningMode.dailyEarnings.count > 0) {
            for (int i = 0; i < dateArr.count; i++) {
                NSString *title =[SYTimeHelper timeWithTimeIntervalString:dateArr[i]];
//                title = [title substringWithRange:NSMakeRange(title.length - 2, 2)];
//                title = [NSString stringWithFormat:@"%@日",title];
                [xVals addObject:title];
            }
        } else {
            NSString *title = dateArr[0];
//            title = [title stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//            title = [title substringWithRange:NSMakeRange(title.length - 5, 5)];
//            NSArray *array = [title componentsSeparatedByString:@"/"];
//            NSMutableArray *mutArray = [NSMutableArray arrayWithObjects:array[1],array[0], nil];
//            title = [mutArray componentsJoinedByString:@"/"];
            [xVals addObject:title];
        }
    
    self.chartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    
    
    LineChartDataSet *set1 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals1;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"收入(单位:元)"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:kAppColorAuxiliaryLightOrange];
        [set1 setCircleColor:kAppColorAuxiliaryLightOrange];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = kAppColorAuxiliaryLightOrange;
        set1.highlightColor = kAppColorAuxiliaryLightOrange;
        set1.drawCircleHoleEnabled = NO;
        
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.redColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        [data setDrawValues:NO];
        _chartView.xAxis.granularity = 1.0f;
        _chartView.xAxis.axisMinimum = data.xMin - 0.8;
        _chartView.xAxis.axisMaximum = data.xMax + 0.8;
        _chartView.data = data;
    }
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
    
    [_chartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    //[_chartView moveViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];
    //[_chartView zoomAndCenterViewAnimatedWithScaleX:1.8 scaleY:1.8 xValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
