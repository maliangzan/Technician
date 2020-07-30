//
//  OrdersViewController.m
//  Technician
//
//  Created by 马良赞 on 16/12/26.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrdersCell.h"
#import "OCHomeHeaderView.h"
#import "ServiceDetailsViewController.h"
//#import "BaiduMapViewController.h"
#import "SYNearView.h"
#import "CustomerViewController.h"
#import "ServiceTimeViewController.h"
#import "SetOrderViewController.h"
#import "MoreServiceView.h"
#import "SYServiceOrderApi.h"
#include <objc/runtime.h>
#import "SYNearbyOrderMode.h"
#import "SYNearbyServiceMode.h"
#import <MJRefresh.h>
#import "SYGrabASingleApi.h"
#import "SYStartServiceApi.h"
#import "SYServiceAddressMapViewController.h"

#define LOCATION_BTN_HEIGHT 37
#define NEAR_VIEW_HEIGHT 55

#define DEFAULT_LATITUDE 0.000000
#define DEFAULT_LONGITUDE 0.000000

typedef NS_ENUM(NSInteger, OrderSortMethod) {
    OrderSortByTheTime = 0,//发布时间
    OrderSortByTheDoor = 1,//上门时间
    OrderSortByTheDistance = 2,//距离
};

@interface OrdersViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SYNearViewDelegate,OrdersCellDelegate,MoreServiceViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIButton *locationBtn;
@property (nonatomic,strong) SYNearView *nearView;
@property (nonatomic,strong) MoreServiceView *moreServiceView;
@property (nonatomic,assign) CGFloat moreViewHeight;
@property (nonatomic,strong) UIView *backCoverView;
@property (nonatomic,strong) NSMutableArray *allServiceArray;
@property (nonatomic,strong) NSMutableArray *selecteServiceArray;
@property (nonatomic,strong) NSMutableArray *nearbyOrderArray;
@property (nonatomic,assign) OrderSortMethod sortMethod;
@property (nonatomic,assign) BOOL isNear;
@property (nonatomic,assign) BOOL theSorting;//正序或逆序排列,默认为正序排列,0—正序排列1—逆序排列
@property (nonatomic,strong) SYNearbyOrderMode *testOrder;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageNum;

@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationSYServiceAddressMapViewControllerSelectedAddressAction, @selector(changeAddressAction));
    ObserveNotification(kNotificationUpdateLocations, @selector(updateLocations));
    ObserveNotification(kNotificationChangeOrderState, @selector(changeOrderStateAction));
    ObserveNotification(kNotificationLoginSuccess, @selector(loadData));
    ObserveNotification(kNotificationOrdersViewControllerRefresh, @selector(loadData));
    
    [self bindData];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view hideHUD];
    self.moreServiceView.frame = CGRectMake(0, kCustomNavHeight + LOCATION_BTN_HEIGHT - 30, KscreenWidth, 30);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark superMethod
- (void)buildUI{
    [super buildUI];
    
    self.backBtn.hidden = YES;
    self.titleLabel.text = Localized(@"服务接单");
    self.moreBtn.hidden = NO;
    [self.moreBtn setImage:PNGIMAGE(@"custom_service") forState:(UIControlStateNormal)];
    WeakSelf;
    self.rightBtn = ^{
        [weakself rightButtonAction];
    };
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.moreServiceView];
    [self.view addSubview:self.locationBtn];
    [self.view bringSubviewToFront:self.navImg];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.pageNum = 1;
        [weakself loadData];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新数据
        weakself.pageNum = 1;
        [weakself loadData];
        
        //上拉加载更多
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
- (void)rightButtonAction{
    [ProgressHUD dismiss];
    [self closeMoreView];
    CustomerViewController *customVC = [[CustomerViewController alloc] init];
    customVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:customVC animated:YES];
}

- (void)locationButtonAction:(UIButton *)btn{
    [ProgressHUD dismiss];
    if ([[SYAppConfig shared] isOpenLocationService]) {
        [self gotoBaiduMapVC];
    } else {
        [self tipsOpenLocationAction];
    }
}

- (void)updateLocations{
    [self settingTitleForLocationButton];
    [self loadData];
}

- (void)changeOrderStateAction{
    [self.tableView reloadData];
}

- (void)tipsOpenLocationAction{
    [self closeMoreView];
    [[SYAppConfig shared] tipsOpenLocation];
}
- (void)settingTitleForLocationButton{
    if ([[SYAppConfig shared] isOpenLocationService]) {
        NSString *address = [SYAppConfig shared].me.locationAddress;
        address = isNull(address) == YES ? @"" : address;
        [_locationBtn setTitle:[NSString stringWithFormat:@"  您现在的位置：%@",address] forState:UIControlStateNormal];
    } else {
        [_locationBtn setTitle:[NSString stringWithFormat:@"  您现在的位置：%@",@"定位服务未开启"] forState:UIControlStateNormal];
    }
}

- (void)changeAddressAction{
    NSString *address = [NSString stringWithFormat:@"%@%@",[SYAppConfig shared].me.address,[SYAppConfig shared].me.detailAddress];
    [self.locationBtn setTitle:[NSString stringWithFormat:@"  您现在的位置：%@",address] forState:UIControlStateNormal];
}

- (void)bindData{
    self.sortMethod = OrderSortByTheTime;
    self.isNear = YES;
    self.theSorting = YES;
    
    self.pageNum = 1;
    self.pageSize = 10;
    self.totalCount = 10;
}

- (void)loadData{
    if (([SYAppConfig shared].me.currentLocation.coordinate.latitude == DEFAULT_LATITUDE && [SYAppConfig shared].me.currentLocation.coordinate.longitude == DEFAULT_LONGITUDE) && ![SYAppConfig shared].me.changeLocation) {
        
        if ([[SYAppConfig shared] isOpenLocationService]) {
            [[SYAppConfig shared] startLocation];
            [self.view showHUDForError:Localized(@"正在获取您的位置信息，请稍后...")];
            [self.tableView.header endRefreshing];
        } else {
            [self.view hideHUD];
            [self.tableView.header endRefreshing];
            [self tipsOpenLocationAction];
        }
        return;
    }
    
    NSMutableString *cidUrlStr = [NSMutableString string];
    for (SYNearbyServiceMode *serviceMode in self.selecteServiceArray) {
        NSString *cidString = [NSString stringWithFormat:@"&cids=%@",serviceMode.serviceID];
        [cidUrlStr appendString:cidString];
    }
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/getNearbyOrders.do?tid=%@&lat=%lf&lng=%lf&rank=%ld%@&array=%d",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        location.coordinate.latitude,//纬度
                        location.coordinate.longitude,//经度
                        (long)self.sortMethod,//排序方式
                        cidUrlStr,
                        self.theSorting
                        ];
    WeakSelf;
    [ProgressHUD show:Localized(@"正在拼命加载，请稍后...")];
    //    [ProgressHUD show:Localized(@"正在拼命加载，请稍后...") hide:NO];
    //    [self.view showHUDWithMessage:Localized(@"拼命加载中...")];
    SYServiceOrderApi *api = [[SYServiceOrderApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [ProgressHUD dismiss];
        [weakself.view hideHUD];
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        if (weakself.pageNum == 1) {
            [weakself.nearbyOrderArray removeAllObjects];
        }
        
        weakself.totalCount = [request.responseObject[@"data"][@"totalCount"] integerValue];
        if (!isNullArray([request.responseObject[@"data"] objectForKey:@"nearbyOrders"])) {
            for (NSDictionary *dic in [request.responseObject[@"data"] objectForKey:@"nearbyOrders"]) {
                SYNearbyOrderMode *nearbyMode = [SYNearbyOrderMode fromJSONDictionary:dic];
                
                [weakself.nearbyOrderArray addObject:nearbyMode];
            }
        }
        //        [weakself.nearbyOrderArray addObject:self.testOrder];
        
        [weakself.allServiceArray removeAllObjects];
        for (NSDictionary *dic in [request.responseObject[@"data"] objectForKey:@"categories"]) {
            SYNearbyServiceMode *serviceMode = [SYNearbyServiceMode fromJSONDictionary:dic];
            for (SYNearbyServiceMode *mode in weakself.selecteServiceArray) {
                if (serviceMode.serviceID == mode.serviceID) {
                    serviceMode.isSelected = YES;
                    break;
                } else {
                    serviceMode.isSelected = NO;
                }
            }
            
            [weakself.allServiceArray addObject:serviceMode];
        }
        
        if (!isNullArray(weakself.allServiceArray)) {
            [weakself configNearView];
        }
        
        [weakself.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [ProgressHUD dismiss];
        [weakself.view hideHUD];
        [weakself.tableView.header endRefreshing];
        [weakself.tableView.footer endRefreshing];
        NSLog(@"%@", request.error);
    }];
}

- (void)configNearView{
    
    NSInteger serviceCount = self.allServiceArray.count;
    switch (serviceCount) {
        case 0:
        {
            [self nearViewButtonUserInteractionEnabled:YES firstButton:NO secondButton:NO thirdButton:NO];
        }
            break;
        case 1:
        {
            [self nearViewButtonUserInteractionEnabled:YES firstButton:YES secondButton:NO thirdButton:NO];
            [self configButton:self.nearView.firstBtn atIndex:0];
            
        }
            break;
        case 2:
        {
            [self nearViewButtonUserInteractionEnabled:YES firstButton:YES secondButton:YES thirdButton:NO];
            [self configButton:self.nearView.firstBtn atIndex:0];
            [self configButton:self.nearView.secondBtn atIndex:1];
        }
            break;
        case 3:
        {
            [self nearViewButtonUserInteractionEnabled:YES firstButton:YES secondButton:YES thirdButton:YES];
            [self configButton:self.nearView.firstBtn atIndex:0];
            [self configButton:self.nearView.secondBtn atIndex:1];
            [self configButton:self.nearView.thirdBtn atIndex:2];
            
        }
            break;
            
        default:
        {
            [self nearViewButtonUserInteractionEnabled:YES firstButton:YES secondButton:YES thirdButton:YES];
            [self configButton:self.nearView.firstBtn atIndex:0];
            [self configButton:self.nearView.secondBtn atIndex:1];
            [self configButton:self.nearView.thirdBtn atIndex:2];
            
        }
            break;
    }
    
}

- (void)nearViewButtonUserInteractionEnabled:(BOOL)near firstButton:(BOOL)first secondButton:(BOOL)second thirdButton:(BOOL)third{
    self.nearView.nearBtn.userInteractionEnabled = near;
    self.nearView.firstBtn.userInteractionEnabled = first;
    self.nearView.secondBtn.userInteractionEnabled = second;
    self.nearView.thirdBtn.userInteractionEnabled = third;
}

- (void)configButton:(UIButton *)btn atIndex:(NSInteger)index{
    SYNearbyServiceMode *serciceMode = [self.allServiceArray objectAtIndex:index];
    btn.selected = serciceMode.isSelected;
    [btn setTitle:serciceMode.name forState:(UIControlStateNormal)];
}

-(void)gotoBaiduMapVC{
    [self closeMoreView];
    SYServiceAddressMapViewController *mapVC = [[SYServiceAddressMapViewController alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark method
- (void)showMoreService{
    self.moreServiceView.dataArray = self.allServiceArray;
    [self.moreServiceView.myCollectionView reloadData];
    NSInteger remainder = self.allServiceArray.count % 4;
    NSInteger numOfLine = self.allServiceArray.count / 4;
    if (remainder != 0) {
        numOfLine += 1;
    }
    self.moreViewHeight = 30 * numOfLine + 30;
    
    [self.view addSubview:self.backCoverView];
    WeakSelf;
    CGFloat moreViewW = KscreenWidth;
    CGFloat moreViewH = self.moreViewHeight;
    CGFloat moreViewX = 0;
    CGFloat moreViewY = kCustomNavHeight + LOCATION_BTN_HEIGHT;
    
    CGFloat backViewX = moreViewX;
    CGFloat backViewY = moreViewY + self.moreViewHeight;
    CGFloat backViewW = moreViewW;
    CGFloat backViewH = KscreenHeight - backViewY;
    [UIView animateWithDuration:0.5 animations:^{
        weakself.moreServiceView.frame = CGRectMake(moreViewX, moreViewY, moreViewW, moreViewH);
        weakself.backCoverView.frame = CGRectMake(backViewX, backViewY, backViewW, backViewH);
    }];
}

- (void)orderByReleaseTime{
    self.nearView.releaseTimeBtn.selected = YES;
    self.nearView.doorTimeBtn.selected = NO;
    self.nearView.distanceBtn.selected = NO;
    self.theSorting = !self.theSorting;
    [self configNearViewImageViewCurrentButton:self.nearView.releaseTimeBtn];
    self.sortMethod = OrderSortByTheTime;
    [self loadData];
    
}

- (void)orderByTheDoorTime{
    self.nearView.doorTimeBtn.selected = YES;
    self.nearView.releaseTimeBtn.selected = NO;
    self.nearView.distanceBtn.selected = NO;
    
    self.theSorting = !self.theSorting;
    [self configNearViewImageViewCurrentButton:self.nearView.doorTimeBtn];
    self.sortMethod = OrderSortByTheDoor;
    [self loadData];
}

- (void)orderByTheDistance{
    self.nearView.distanceBtn.selected = YES;
    self.nearView.releaseTimeBtn.selected = NO;
    self.nearView.doorTimeBtn.selected = NO;
    self.theSorting = !self.theSorting;
    [self configNearViewImageViewCurrentButton:self.nearView.distanceBtn];
    self.sortMethod = OrderSortByTheDistance;
    [self loadData];
}

- (void)configNearViewImageViewCurrentButton:(UIButton *)btn{
    
    NSInteger index = btn.tag - 100;
    
    switch (index) {
        case 5:
        {
            if (self.theSorting) {
                self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_down");
            }else{
                self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_up");
            }
            
            self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_default");
            self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_default");

        }
            break;
        case 6:
        {
            self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_default");
            
            if (self.theSorting) {
                self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_down");
            }else{
                self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_up");
            }
            
            self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_default");
            
        }
            break;
        case 7:
        {
            self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_default");
            self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_default");
 
            if (self.theSorting) {
                self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_down");
            }else{
                self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_up");
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)selectedImage:(NSString *)seleImg unselectedImage:(NSString *)unSeleImg{
    if (self.nearView.releaseTimeBtn.selected) {
        self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_down");
    }else{
        self.nearView.releaseTimeImgView.image = PNGIMAGE(@"orderlist_up");
    }
    
    if (self.nearView.doorTimeBtn.selected) {
        self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_down");
    }else{
        self.nearView.doorImgView.image = PNGIMAGE(@"orderlist_up");
    }
    
    if (self.nearView.distanceBtn.selected) {
        self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_down");
    }else{
        self.nearView.distanceImgView.image = PNGIMAGE(@"orderlist_up");
    }
}

- (void)goToMyOrderAtIndex:(NSInteger)index{
    SetOrderViewController *orderVC = [[SetOrderViewController alloc] init];
    orderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
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
    [self.view showHUDForError:Localized(@"抢单失败，response为false！")];
}

- (void)startServiceTimeWithOrder:(SYNearbyOrderMode *)nearbyMode{
    [[SYAppConfig shared] startServiceTimeWithOrder:nearbyMode withSuperViewController:self];
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
    SYNearbyOrderMode *nearbyMode = [self.nearbyOrderArray objectAtIndex:indexP.row];
    [self startServiceTimeWithOrder:nearbyMode];
}

- (void)cliackStartBtnFWZAt:(OrdersCell *)cell{
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
        [weakself orderWithCell:cell];
    } failureBlock:^(id error) {
        
    }];
}

- (void)orderWithCell:(OrdersCell *)cell{
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
    SYNearbyOrderMode *nearbyMode = [self.nearbyOrderArray objectAtIndex:indexP.row];
    WeakSelf;
    SYOrderMode *order = [SYOrderMode fromJSONDictionary:nearbyMode.order];
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/scrambleOrder?tid=%@&oid=%@",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        order.orderID//oid
                        ];
    [self.view showHUDWithMessage:Localized(@"接单中...")];
    SYGrabASingleApi *api = [[SYGrabASingleApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [ProgressHUD dismiss];
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [weakself.view hideHUD];
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
        [ProgressHUD dismiss];
        [[UIApplication sharedApplication].keyWindow hideHUD];
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"接单失败,连接不到服务器！")];
        //        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

#pragma mark MoreServiceViewDelegate

- (void)selectServiceAtIndexPath:(NSIndexPath *)indexPath{
    SYNearbyServiceMode *serviceMode = [self.allServiceArray objectAtIndex:indexPath.row];
    if (!serviceMode.isSelected) {
        if (![self.selecteServiceArray containsObject:serviceMode]) {
            serviceMode.isSelected = YES;
            [self.selecteServiceArray addObject:serviceMode];
        }
    } else {
        if ([self.selecteServiceArray containsObject:serviceMode]) {
            [self.selecteServiceArray removeObject:serviceMode];
        }
    }
    
    switch (indexPath.row) {
        case 0:
        {
            self.nearView.firstBtn.selected = serviceMode.isSelected;
        }
            break;
        case 1:
        {
            self.nearView.secondBtn.selected = serviceMode.isSelected;
        }
            break;
        case 2:
        {
            self.nearView.thirdBtn.selected = serviceMode.isSelected;
        }
            break;
            
        default:
            break;
    }
}

- (void)closeMoreServiceView{
    [self closeMoreView];
    
    if (!(self.selecteServiceArray.count == 0)) {
        [self loadData];
    }
}

- (void)closeMoreView{
    [self.backCoverView removeFromSuperview];
    WeakSelf;
    CGFloat moreViewW = KscreenWidth;
    CGFloat moreViewH = 30;
    CGFloat moreViewX = 0;
    CGFloat moreViewY = kCustomNavHeight + LOCATION_BTN_HEIGHT - moreViewH;
    [UIView animateWithDuration:0.5 animations:^{
        weakself.moreServiceView.frame = CGRectMake(moreViewX, moreViewY, moreViewW, moreViewH);
    }];
}

#pragma mark SYNearViewDelegate
- (void)nearViewClickButton:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:
        {
            //附近
            [self clickButton:self.nearView.nearBtn AtIndex:0];
        }
            break;
        case 1:
        {
            //第一个btn
            [self clickButton:self.nearView.firstBtn AtIndex:0];
        }
            break;
        case 2:
        {
            //第二个btn
            [self clickButton:self.nearView.secondBtn AtIndex:1];
        }
            break;
        case 3:
        {
            //第三个btn
            [self clickButton:self.nearView.thirdBtn AtIndex:2];
        }
            break;
        case 4:
        {
            //more 更多
            [self showMoreService];
        }
            break;
        case 5:
        {
            //发布时间
            [self orderByReleaseTime];
        }
            break;
        case 6:
        {
            //上门时间
            [self orderByTheDoorTime];
        }
            break;
        case 7:
        {
            //距离
            [self orderByTheDistance];
        }
            break;
            
        default:
            break;
    }
}

- (void)clickButton:(UIButton *)btn AtIndex:(NSInteger)index{
    if (btn.tag == 100) {
        [self loadData];
        return;
    }
    
    btn.selected = !btn.selected;
    
    if (!(self.allServiceArray.count > 0)) {
        //        self.isNear = btn.selected;
        //        [self loadData];
        return;
    }
    
    if (btn.selected && btn.tag != 100) {
        SYNearbyServiceMode *mode = [self.allServiceArray objectAtIndex:index];
        
        if (![self.selecteServiceArray containsObject:mode]) {
            mode.isSelected = YES;
            [self.selecteServiceArray addObject:[self.allServiceArray objectAtIndex:index]];
        }
    } else if (btn.tag != 100) {
        SYNearbyServiceMode *mode = [self.allServiceArray objectAtIndex:index];
        
        if ([self.selecteServiceArray containsObject:mode]) {
            [self.selecteServiceArray removeObject:mode];
        }
    }
    
    [self loadData];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.nearbyOrderArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrdersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.sourceOfOrderBtn.hidden = YES;
    SYNearbyOrderMode *order = [self.nearbyOrderArray objectAtIndex:indexPath.section];
    [cell configCellWithNearbyOrderMode:order source:1];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYNearbyOrderMode *order = [self.nearbyOrderArray objectAtIndex:indexPath.section];
    SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:order.sLocation];
    NSString *serviceAddressStr = [NSString stringWithFormat:@"%@",isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress];
    
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:order.order];
    NSString *markStr = [NSString stringWithFormat:@"备注：%@",orderMode.otherRequirement];
    CGFloat servicePlaceTileLabelWidth = [NSString widthForString:@"服务地点：" labelHeight:15*kHeightFactor fontOfSize:12*kWidthFactor] + 3;
    SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:order.serviceInfo];
    NSString *titleStr = [NSString stringWithFormat:@"%@   (%@分钟)",isNull(serviceInfoMode.name) == YES ? @"":serviceInfoMode.name,isNull([serviceInfoMode.serviceTotalTime stringValue]) == YES ? @"0":serviceInfoMode.serviceTotalTime];
    return
    + 160.0*kHeightFactor
    - 20*kHeightFactor
    + [NSString heightForString:serviceAddressStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor - servicePlaceTileLabelWidth) fontOfSize:12*kWidthFactor]
    + [NSString heightForString:markStr labelWidth:(KscreenWidth - 20*kWidthFactor - 8*kWidthFactor) fontOfSize:10*kWidthFactor]
    + [NSString heightForString:titleStr labelWidth:(KscreenWidth - 20*kWidthFactor - 65*kWidthFactor - 55*kWidthFactor) fontOfSize:12*kWidthFactor];
}
- (CGFloat)tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    //    return 20.0;
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *reuseIdetify = [NSString stringWithFormat:@"OCHomeHeaderView"];
    OCHomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdetify];
    if (!headerView) {
        headerView = [[OCHomeHeaderView alloc]initWithReuseIdentifier:reuseIdetify];
    }
    //    headerView.titlelab.text = @"含感谢费10元。接单越多，奖励越多哦";
    headerView.titlelab.text = @"";
    return headerView;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailsViewController *detailVC = [ServiceDetailsViewController new];
    detailVC.orderListMode = [self.nearbyOrderArray objectAtIndex:indexPath.section];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return PNGIMAGE(@"pic_nothing");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无服务");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}

#pragma mark 懒加载
- (MoreServiceView *)moreServiceView{
    if (!_moreServiceView) {
        NSInteger remainder = self.allServiceArray.count % 4;
        NSInteger numOfLine = self.allServiceArray.count / 4;
        if (remainder != 0) {
            numOfLine += 1;
        }
        self.moreViewHeight = 30 * numOfLine + 30;
        
        CGFloat moreViewW = KscreenWidth;
        CGFloat moreViewH = self.moreViewHeight;
        CGFloat moreViewX = 0;
        CGFloat moreViewY = kCustomNavHeight + LOCATION_BTN_HEIGHT - moreViewH;
        _moreServiceView = [[MoreServiceView alloc] initWithFrame:CGRectMake(moreViewX, moreViewY, moreViewW, moreViewH)];
        _moreServiceView.dataArray = self.allServiceArray;
        _moreServiceView.delegate = self;
        
    }
    return _moreServiceView;
}

- (UIView *)backCoverView{
    if (!_backCoverView) {
        CGFloat backViewX = 0;
        CGFloat backViewY = kCustomNavHeight + LOCATION_BTN_HEIGHT;
        CGFloat backViewW = KscreenWidth;
        CGFloat backViewH = KscreenHeight - backViewY;
        _backCoverView = [[UIView alloc] initWithFrame:CGRectMake(backViewX, backViewY, backViewW, backViewH)];
        _backCoverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
    return _backCoverView;
}

- (NSMutableArray *)allServiceArray{
    if (!_allServiceArray) {
        _allServiceArray = [NSMutableArray array];
    }
    return _allServiceArray;
}

- (SYNearView *)nearView{
    if (!_nearView) {
        _nearView = [[[NSBundle mainBundle] loadNibNamed:@"SYNearView" owner:nil options:nil] objectAtIndex:0];
        _nearView.frame = CGRectMake(0, 0, KscreenWidth, NEAR_VIEW_HEIGHT);
        _nearView.delegate = self;
    }
    return _nearView;
}

-(UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _locationBtn.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, LOCATION_BTN_HEIGHT);
        [_locationBtn setBackgroundColor:getColor(@"1cc6a2")];
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:10*kWidthFactor];
        [_locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self settingTitleForLocationButton];
        [_locationBtn addTarget:self action:@selector(locationButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _locationBtn;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + LOCATION_BTN_HEIGHT, KscreenWidth, KscreenHeight - kCustomNavHeight - LOCATION_BTN_HEIGHT - 49) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableHeaderView = self.nearView;
        [_tableView registerClass:[OrdersCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSMutableArray *)nearbyOrderArray{
    if (!_nearbyOrderArray) {
        _nearbyOrderArray = [NSMutableArray array];
    }
    return _nearbyOrderArray;
}

- (NSMutableArray *)selecteServiceArray{
    if (!_selecteServiceArray) {
        _selecteServiceArray = [NSMutableArray array];
    }
    return _selecteServiceArray;
}

- (SYNearbyOrderMode *)testOrder{
    
    if (!_testOrder) {
        _testOrder = [[SYNearbyOrderMode alloc] init];
        _testOrder.distance = @100;
        _testOrder.order = @{@"appointServiceTime":@"2017-08-09 15:09:00",@"otherRequirement":@"客户端"};
        _testOrder.sLocation = @{@"address":@"设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面设置限制线绘制在后面"};
    }
    return _testOrder;
}

@end
