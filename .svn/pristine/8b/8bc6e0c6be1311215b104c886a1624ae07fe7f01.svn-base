//
//  serviceDetailsVC.m
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "ServiceDetailsViewController.h"
#import "OrderHeadView.h"
#import "TwoContentLabelCell.h"
#import "ServiceAddressCell.h"
#import "ThreeLabelCell.h"
#import "TwoLabelCell.h"
#import "OrdersBtnCell.h"
#import "SYOrderDetailApi.h"
#import "SYNearbyOrderMode.h"
#import "SYGrabASingleApi.h"

static NSString *twoContentLabelCellID = @"TwoContentLabelCell";
static NSString *addressCellID  = @"ServiceAddressCell";
static NSString *threeLabelCellID = @"ThreeLabelCell";
static NSString *twoLabelCellID = @"TwoLabelCell";
static NSString *orderBtnCellID = @"OrdersBtnCell";
@interface ServiceDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceAddressCellDelegate,OrdersBtnCellDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong) OrderHeadView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) SYNearbyOrderMode *nearbyMode;
@property (nonatomic,assign) BOOL isAgreeServiceAgreement;

@end

@implementation ServiceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindData];
    [self loadData];
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"服务详情";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
        
    }];
}

#pragma mark method
- (void)bindData{
    self.isAgreeServiceAgreement = YES;
}

- (void)loadData{
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }

    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:self.orderListMode.order];
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/getTechnOrderInfo?oid=%@&tid=%@",
                        URL_HTTP_Base_Get,
                        orderMode.orderID,//
                        [SYAppConfig shared].me.userID
                        
                        ];
    if (location) {
        urlStr = [NSString stringWithFormat:@"%@&lng=%f&lat=%f",
                  urlStr,
                  location.coordinate.longitude,
                  location.coordinate.latitude
                  ];
    }
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    SYOrderDetailApi *api = [[SYOrderDetailApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        weakself.nearbyMode = [SYNearbyOrderMode fromJSONDictionary:[request.responseObject objectForKey:@"data"]];
        [weakself.headView configHeadViewWith:weakself.nearbyMode];
        SYServiceInfoMode *serviceMode = [SYServiceInfoMode fromJSONDictionary:weakself.nearbyMode.serviceInfo];
        CGFloat headHeight = 100 + [NSString heightForString:serviceMode.SerciceDescription labelWidth:KscreenWidth - 100 fontOfSize:14];
        if (headHeight < 120) {
            headHeight = 120;
        }
        [weakself configHeadViewWithFrame:CGRectMake(0, 0, KscreenWidth, headHeight)];

        [weakself.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)configHeadViewWithFrame:(CGRect)frame{
    self.headView.frame = frame;
    self.tableView.tableHeaderView = self.headView;
}

- (TwoContentLabelCell *)gettingTwoContentCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TwoContentLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoContentLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = [subArray firstObject];
        cell.titleLabel.text = dic[@"title"];
        cell.contentLabel.text = dic[@"content"];
    }
    
    return cell;
}

- (TwoLabelCell *)gettingTwoLabelCellInTableview:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TwoLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.textColor = kAppColorTextMiddleBlack;
    cell.sexBtn.hidden = YES;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = [subArray firstObject];
        cell.titleLabel.text = dic[@"title"];
        cell.contentLabel.text = dic[@"content"];
    }
    return cell;
}

- (ServiceAddressCell *)gettingAddressCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ServiceAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = [subArray firstObject];
        [cell configServiceAddressCellWithDictionary:dic];
    }
    
    return cell;
}

- (ThreeLabelCell *)gettingThreeLabelInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ThreeLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:threeLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = [subArray firstObject];
        NSString *titleStr = dic[@"title"];
        cell.titleLabel.text = [titleStr substringWithRange:NSMakeRange(0, 4)];
        cell.tipLabel.text = [titleStr substringWithRange:NSMakeRange(4, titleStr.length - 4)];
        cell.priceLabel.text = dic[@"content"];
    }
    
    return cell;
}

- (OrdersBtnCell *)gettingOrderBtnCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    OrdersBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:orderBtnCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = [subArray firstObject];
        [cell.occeptOrderBtn setTitle:dic[@"title"] forState:(UIControlStateNormal)];
    }
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:self.orderListMode.order];
    if ([orderMode.state isEqualToString:@"dqr"]) {
        if ([[SYAppConfig shared].me.state isEqualToString:@"jdz"]) {
            [cell.occeptOrderBtn setBackgroundImage:PNGIMAGE(@"login_Bt_Img") forState:(UIControlStateNormal)];
            cell.occeptOrderBtn.userInteractionEnabled = YES;
        } else {
            [cell.occeptOrderBtn setBackgroundImage:PNGIMAGE(@"btn_bg_light_gray") forState:(UIControlStateNormal)];
            cell.occeptOrderBtn.userInteractionEnabled = YES;
        }
        
    } else {
        [cell.occeptOrderBtn setBackgroundImage:PNGIMAGE(@"btn_bg_light_gray") forState:(UIControlStateNormal)];
        cell.occeptOrderBtn.userInteractionEnabled = YES;
    }
    
    return cell;
}

- (void)showHintView{
    WeakSelf;
    [[SYAlertViewTwo(@"已成功接单", @"请及时安排好上门时间。出门前请务必提前和客户电话确认。祝您工作愉快！", @"取消", @"确定") setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }] show];
}
- (void)showFaildView{
    [self.view showHUDForError:Localized(@"系统异常！")];
}
#pragma mark OrdersBtnCellDelegate
- (void)acceptOrder{
    WeakSelf;
    [[SYAppConfig shared] loadTheUnionStateWithSuccessBlock:^(id responseObject) {
        [weakself canEcceptOrder];
    } failureBlock:^(id error) {
        
    }];
}

- (void)canEcceptOrder{
    SYOrderMode *order = [SYOrderMode fromJSONDictionary:self.nearbyMode.order];
    
    if (![[SYAppConfig shared].me.stateEvaluation isEqualToString:@"ytg"]) {
        [self.view showHUDForError:Localized(@"加盟通过后才能接单哦！")];
        return;
    }
    
    if (![order.state isEqualToString:@"dqr"]) {
        [self.view showHUDForError:Localized(@"不能重复接单！")];
        return;
    }
    
    if ([[SYAppConfig shared].me.state isEqualToString:@"xxz"]) {
        [self.view showHUDForError:Localized(@"休息中，暂不能接单！")];
        return;
    }
    
    if (!self.isAgreeServiceAgreement) {
        [self.view showHUDForError:Localized(@"接单前请同意《服务标准及责任协议》")];
        return;
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/scrambleOrder?tid=%@&oid=%@",
                        URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,//tid
                        order.orderID//oid
                        ];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    SYGrabASingleApi *api = [[SYGrabASingleApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        if ([request.responseObject[@"response"] boolValue]) {
            
            NSInteger code = [request.responseObject[@"code"] integerValue];
            switch (code) {
                case 0:
                {
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
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
}

- (void)agreeToTheServiceAgreeMent:(BOOL)isAgree{
    self.isAgreeServiceAgreement = isAgree;
}

#pragma mark ServiceAddressCellDelegate
- (void)contactUserAtCell:(ServiceAddressCell *)cell{
    //
    if (isValidateMobile(self.nearbyMode.user[@"mobilephone"])) {
        CallWithPhoneNumber(self.nearbyMode.user[@"mobilephone"]);
    } else {
        [self.view showHUDForInfo:Localized(@"暂无联系方式！")];
    }
    
}

- (void)locationTheAddressAtCell:(ServiceAddressCell *)cell{
    //
}
#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            return [self gettingTwoContentCellInTableView:tableView atIndexPath:indexPath];
        }
            break;
        case 1:
        {
            return [self gettingTwoLabelCellInTableview:tableView atIndexPath:indexPath];
            
        }
            break;
        case 2:
        {
            
            return [self gettingAddressCellInTableView:tableView atIndexPath:indexPath];
            
        }
            break;
        case 3:{
            return [self gettingThreeLabelInTableView:tableView atIndexPath:indexPath];
        }
            break;
        case 4:{
            return [self gettingOrderBtnCellInTableView:tableView atIndexPath:indexPath];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    switch (indexPath.section) {
        case 0:
        {
            //其他要求
            NSDictionary *dic = subArray[0];
            return 70 + [NSString heightForString:dic[@"content"] labelWidth:KscreenWidth - 20 fontOfSize:15];
        }
            break;
        case 2:
        {
            
            //服务地
            NSDictionary *dic = subArray[0];
            return 100 + [NSString heightForString:dic[@"address"] labelWidth:KscreenWidth - 40 fontOfSize:15];
            
        }
            break;
        case 4:
        {
            
            //马上接单
            return 150;
            
        }
            break;
            
        default:
        {
            
            return 44;
            
            
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kAppColorBackground;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (self.nearbyMode) {
        SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:self.nearbyMode.order];
        JYUserMode *userMode = [JYUserMode fromJSONDictionary:self.nearbyMode.user];
        SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:self.nearbyMode.sLocation];
        SYPayInfoMode *payInfo = [SYPayInfoMode fromJSONDictionary:self.nearbyMode.payInfo];
        SYTechnMode *technMode = [SYTechnMode fromJSONDictionary:self.nearbyMode.techn];
        SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:self.nearbyMode.serviceInfo];
        
        NSString *paymentString = [NSString stringWithFormat:@"%.2f",[serviceInfoMode.price floatValue] / 100];
        NSString *priceStr = [NSString stringWithFormat:@"¥ %@",isNull([serviceInfoMode.price stringValue]) == YES ? @"0.00" : paymentString];
        
        _dataArray = [NSMutableArray arrayWithArray:
                      @[
                        //第一段 数组
                        @[@{@"title":@"其他要求：",
                            @"content":isNull(orderMode.otherRequirement) == YES ? @"无":orderMode.otherRequirement}],
                        //第二段 数组
                        @[@{@"title":@"服务时间：",
                            @"content":isNull(orderMode.appointServiceTime) == YES ? @"":orderMode.appointServiceTime},
                          ],
                        //第三段 数组
                        @[@{@"title":@"使用者：",
                            @"content":isNull(userMode.name) == YES ? @"":userMode.name,
                            @"sex":isNull([NSString stringWithFormat:@"%@",userMode.sex]) == YES ? @"0":[NSString stringWithFormat:@"%@",userMode.sex],
                            @"address":isNull(locationMode.sAddress) == YES ? @"" : locationMode.sAddress,
                            @"distanceStr":[NSString stringWithFormat:@"%.2fKm",[self.nearbyMode.distance floatValue]]
                                }
                          ],
                        //第四段 数组
                        
                        @[@{@"title":@"订单金额：",@"content":priceStr}
                          ],
                        //第五段 数组
                        @[@{@"title":@"马上接单"},
                          ],
                        ]
                      ];
    }else{
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (OrderHeadView *)headView{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"OrderHeadView" owner:nil options:nil] objectAtIndex:0];
        _headView.frame = CGRectMake(0, 0, KscreenWidth, 120);
        _headView.stepViewHeight.constant = 0;
        _headView.stepBgView.hidden = YES;
        _headView.staduesBtn.hidden = YES;
        _headView.backgroundColor = kAppColorBackground;
        _headView.cellView.backgroundColor = kAppColorBackground;
        
    }
    return _headView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kAppColorBackground;
        [_tableView registerNib:[UINib nibWithNibName:twoContentLabelCellID bundle:nil] forCellReuseIdentifier:twoContentLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:addressCellID bundle:nil] forCellReuseIdentifier:addressCellID];
        [_tableView registerNib:[UINib nibWithNibName:threeLabelCellID bundle:nil] forCellReuseIdentifier:threeLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:twoLabelCellID bundle:nil] forCellReuseIdentifier:twoLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:orderBtnCellID bundle:nil] forCellReuseIdentifier:orderBtnCellID];
    }
    return _tableView;
}

@end
