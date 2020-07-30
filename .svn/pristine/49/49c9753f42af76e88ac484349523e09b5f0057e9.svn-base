//
//  OrderDetailViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderHeadView.h"
#import "SYTableCell.h"
#import "TwoContentLabelCell.h"
#import "TwoLabelCell.h"
#import "ServiceAddressCell.h"
#import "ThreeLabelCell.h"
#import "SYOrderMode.h"
#import "SYOrderDetailApi.h"
#import "SYNearbyOrderMode.h"
#import "SYTimeHelper.h"
#import "SYServiceInfoMode.h"

static NSString *twoContentLabelCellID = @"TwoContentLabelCell";
static NSString *tableCellID = @"SYTableCell";
static NSString *twoLabelCellID = @"TwoLabelCell";
static NSString *addressCellID  = @"ServiceAddressCell";
static NSString *threeLabelCellID = @"ThreeLabelCell";
//static NSString *YWCString = @"ywc";
static NSString *DQRString = @"dqr";
static NSString *DFKString = @"dfk";
static NSString *DFWString = @"dfw";


@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceAddressCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) OrderHeadView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *totalView;
@property (nonatomic,strong) SYOrderMode *orderMode;
@property (nonatomic,strong) SYNearbyOrderMode *nearbyMode;
@end

@implementation OrderDetailViewController

- (instancetype)initWithMyOrderListMode:(SYNearbyOrderMode *)orderListMode{
    if ([super init]) {
        self.orderListMode = orderListMode;
        self.orderMode = [SYOrderMode fromJSONDictionary:self.orderListMode.order];
    }
    return self;
}

- (instancetype)initWithMyOrderMode:(SYOrderMode *)orderMode{
    if ([super init]) {
        self.orderMode = orderMode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)loadData{
    CLLocation *location = [SYAppConfig shared].me.currentLocation;
    if ([SYAppConfig shared].me.changeLocation) {
        location = [SYAppConfig shared].me.changeLocation;
    }

    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/getTechnOrderInfo?oid=%@&tid=%@",
                        URL_HTTP_Base_Get,
                        self.orderMode.orderID,//
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
        CGFloat headHeight = 180 + [NSString heightForString:serviceMode.SerciceDescription labelWidth:KscreenWidth - 100 fontOfSize:14];
        if (headHeight < 200) {
            headHeight = 200;
        }

        [weakself setupTableHeaderViewWithFrame:CGRectMake(0, 0, KscreenWidth, headHeight)];
        [weakself.tableView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];

}

#pragma mark superMethod
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"订单详情";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
}

#pragma mark method
- (TwoContentLabelCell *)gettingTwoContentCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TwoContentLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoContentLabelCellID];
//    TwoContentLabelCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TwoContentLabelCell" owner:self options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = subArray[0];
        cell.titleLabel.text = Localized(dic[@"title"]);
        cell.contentLabel.text = dic[@"content"];
    }
    
    return cell;
}

- (SYTableCell *)gettingTableCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    SYTableCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    cell.dataArray = [NSMutableArray arrayWithArray:subArray];
    return cell;
}

- (TwoLabelCell *)gettingTwoLabelCellInTableview:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TwoLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.textColor = kAppColorTextMiddleBlack;
    cell.sexBtn.hidden = YES;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    if (subArray.count) {
        NSDictionary *dic = subArray[0];
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
    if (subArray.count > 0) {
        NSDictionary *dic = subArray[0];
        [cell configServiceAddressCellWithDictionary:dic];
        }
    
    return cell;
}

- (ThreeLabelCell *)gettingThreeLabelInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ThreeLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:threeLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dic = subArray[0];
    cell.titleLabel.text = dic[@"title"];
    cell.priceLabel.text = dic[@"content"];
    return cell;
}

#pragma mark ServiceAddressCellDelegate
- (void)contactUserAtCell:(ServiceAddressCell *)cell{
    JYUserMode *userMode = [JYUserMode fromJSONDictionary:self.nearbyMode.user];
    CallWithPhoneNumber(userMode.telephone == nil? userMode.mobilePhone : userMode.telephone);
}

- (void)locationTheAddressAtCell:(ServiceAddressCell *)cell{
    //[SVProgressHUD showErrorWithStatus:@"locationTheAddressAtCell"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.nearbyMode == nil) {
        return 0;
    }
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
            if ([self.orderMode.state isEqualToString:DQRString] ||
                [self.orderMode.state isEqualToString:DFKString] ||
                [self.orderMode.state isEqualToString:DFWString])
            {
                return [self gettingTwoLabelCellInTableview:tableView atIndexPath:indexPath];

            }else{
                return [self gettingTableCellInTableView:tableView atIndexPath:indexPath];
            }
            
        }
            break;
        case 2:
        {
            if ([self.orderMode.state isEqualToString:DQRString] ||
                [self.orderMode.state isEqualToString:DFKString] ||
                [self.orderMode.state isEqualToString:DFWString])
            {
                return [self gettingAddressCellInTableView:tableView atIndexPath:indexPath];
                
            }else{
                return [self gettingTableCellInTableView:tableView atIndexPath:indexPath];
            }
        }
            break;
        case 3:{
            return [self gettingThreeLabelInTableView:tableView atIndexPath:indexPath];
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
            
            if ([self.orderMode.state isEqualToString:DQRString] ||
                [self.orderMode.state isEqualToString:DFKString] ||
                [self.orderMode.state isEqualToString:DFWString])
            {
                //服务地
                NSDictionary *dic = subArray[0];
                return 100 + [NSString heightForString:dic[@"address"] labelWidth:KscreenWidth - 40 fontOfSize:15];
            }else{
                return 30 * subArray.count;
            }
        }
            break;
            
        default:
        {
            if ([self.orderMode.state isEqualToString:DQRString] ||
                [self.orderMode.state isEqualToString:DFKString] ||
                [self.orderMode.state isEqualToString:DFWString])
            {
                return 44;
            }else{
                return 30 * subArray.count;
            }
            
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == self.dataArray.count - 1 && !([self.orderMode.state isEqualToString:DQRString] ||
        [self.orderMode.state isEqualToString:DFKString] ||
        [self.orderMode.state isEqualToString:DFWString]))
    {
        //合计
        return self.totalView;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kAppColorBackground;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == self.dataArray.count - 1 && !([self.orderMode.state isEqualToString:DQRString] ||
                                                 [self.orderMode.state isEqualToString:DFKString] ||
                                                 [self.orderMode.state isEqualToString:DFWString]))
    {
        //合计view的高度
        return 35 * kHeightFactor;
    }
    return 10;
}
#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:self.nearbyMode.order];
        JYUserMode *userMode = [JYUserMode fromJSONDictionary:self.nearbyMode.user];
        SYLocationMode *locationMode = [SYLocationMode fromJSONDictionary:self.nearbyMode.sLocation];
        SYPayInfoMode *payInfo = [SYPayInfoMode fromJSONDictionary:self.nearbyMode.payInfo];
        SYTechnMode *technMode = [SYTechnMode fromJSONDictionary:self.nearbyMode.techn];
        SYServiceInfoMode *serviceInfoMode = [SYServiceInfoMode fromJSONDictionary:self.nearbyMode.serviceInfo];
        
        NSString *tradePrice = [NSString stringWithFormat:@"%.2f",[orderMode.tradePrice floatValue] / 100];
        tradePrice = isNull([orderMode.tradePrice stringValue]) == YES ? @"0.00" : tradePrice;
        
        NSString *scrambleTime = orderMode.scrambleTime;//[orderMode.scrambleTime stringValue];
//        scrambleTime = [self dateTimeOf:scrambleTime];
        if ([self.orderMode.state isEqualToString:DQRString] ||
            [self.orderMode.state isEqualToString:DFKString] ||
            [self.orderMode.state isEqualToString:DFWString]) {
            _dataArray = [NSMutableArray arrayWithArray:
                          @[
                            //第一段 数组
                            @[@{@"title":@"其他要求：",
                                @"content":orderMode.otherRequirement}],
                            //第二段 数组
                            @[@{@"title":@"服务时间：",
                                @"content":orderMode.appointServiceTime},
                              ],
                            //第三段 数组
                            @[@{@"title":@"使用者：",
                                @"content":isNull(userMode.name) == YES ? @"":userMode.name,
                                @"sex":[NSString stringWithFormat:@"%@",userMode.sex],
                                @"address":isNull(locationMode.sAddress) == YES ? @"":locationMode.sAddress,
                                @"distanceStr":[NSString stringWithFormat:@"%.1fkm",[self.nearbyMode.distance floatValue]],
                                
                                }
                              
                              ],
                            //第四段 数组
                            @[@{@"title":@"订单金额",@"content":[NSString stringWithFormat:@"¥ %@",tradePrice]},
                              ],
                            ]
                          ];
        }else{
            NSInteger actServiceTime = 0;;
            if (!isNull(orderMode.actServiceStartTime) && !isNull(orderMode.actServiceEndTime)) {
                actServiceTime = [SYTimeHelper timeIntervalFrom:orderMode.actServiceStartTime to:orderMode.actServiceEndTime];
            }
            
            _dataArray = [NSMutableArray arrayWithArray:
                          @[
                            //第一段 数组
                            @[@{@"title":@"其他要求：",
                                @"content":orderMode.otherRequirement}],
                            //第二段 数组
                            
                            @[@{@"title":@"技师：",@"content":isNull(technMode.realName) == YES ? @"":technMode.realName,@"sex":isNull([NSString stringWithFormat:@"%@",technMode.sex]) == YES ? @"0":[NSString stringWithFormat:@"%@",technMode.sex]},
                              @{@"title":@"使用者：",@"content":isNull(userMode.name) == YES ? @"":userMode.name,@"sex":isNull([NSString stringWithFormat:@"%@",userMode.sex]) == YES ? @"0":[NSString stringWithFormat:@"%@",userMode.sex]},
                              @{@"title":@"服务时间：",@"content":isNull(orderMode.appointServiceTime) == YES ? @"":orderMode.appointServiceTime},
                              @{@"title":@"开始时间：",@"content":isNull(orderMode.actServiceStartTime) == YES ? @"":orderMode.actServiceStartTime},
                              @{@"title":@"结束时间：",@"content":isNull(orderMode.actServiceEndTime) == YES ? @"":orderMode.actServiceEndTime},
                              @{@"title":@"实际时长：",@"content":[NSString stringWithFormat:@"%ld分钟",[self.nearbyMode.realServiceTime integerValue]]}],
                            //第三段 数组
                            
                            @[@{@"title":@"订单编号：",@"content":isNull(orderMode.soNo) == YES ? @"":orderMode.soNo},
                              @{@"title":@"交易流水号：",@"content":isNull(orderMode.transactionId) == YES ? @"":orderMode.transactionId},
                              
                              @{@"title":@"创建时间：",@"content":isNull(orderMode.createTime) == YES ? @"":orderMode.createTime},
                              @{@"title":@"付款时间：",@"content":isNull(payInfo.payTime) == YES ? @"":payInfo.payTime},
                              @{@"title":@"确认时间：",@"content":isNull(scrambleTime) == YES ? @"":scrambleTime}]
                            ]
                          ];
        }
    }
    return _dataArray;
}

- (NSString *)dateTimeOf:(NSString *)timeString{
    
    NSTimeInterval _interval=[timeString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSString *currentDateStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD_HH_mm_ss:date];
    
    return currentDateStr;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:twoContentLabelCellID bundle:nil] forCellReuseIdentifier:twoContentLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:tableCellID bundle:nil] forCellReuseIdentifier:tableCellID];
        [_tableView registerNib:[UINib nibWithNibName:twoLabelCellID bundle:nil] forCellReuseIdentifier:twoLabelCellID];
       [_tableView registerNib:[UINib nibWithNibName:addressCellID bundle:nil] forCellReuseIdentifier:addressCellID];
        [_tableView registerNib:[UINib nibWithNibName:threeLabelCellID bundle:nil] forCellReuseIdentifier:threeLabelCellID];
        
    }
    return _tableView;
}

- (OrderHeadView *)headView{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"OrderHeadView" owner:nil options:nil] objectAtIndex:0];
        _headView.frame = CGRectMake(0, 0, KscreenWidth, 200);
    }
    return _headView;
}

#pragma mark - 设置tableHeaderView
- (void)setupTableHeaderViewWithFrame:(CGRect)frame
{
    // 设置 view 的 frame(将设置 frame 提到设置 tableHeaderView 之前)
    _headView.frame = frame;    // 设置 tableHeaderView
    self.tableView.tableHeaderView = self.headView;
}

- (UIView *)totalView{
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:self.nearbyMode.order];
    if (!_totalView) {
        CGFloat viewHeight = 35 * kHeightFactor;
        _totalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, viewHeight)];
        _totalView.backgroundColor = [UIColor whiteColor];
        CGFloat titleLX = 20;
        CGFloat titleLY = 0;
        CGFloat titleLW = 60;
        CGFloat titleH = viewHeight;
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(titleLX, titleLY, titleLW, titleH)];
        titleL.textColor = kAppColorTextMiddleBlack;
        titleL.text = Localized(@"合计");
        [_totalView addSubview:titleL];
        
        UILabel *totalL = [[UILabel alloc] initWithFrame:CGRectMake(titleLX + titleLW, titleLY, KscreenWidth - titleLX - titleLW - 20, titleH)];
        totalL.textAlignment = NSTextAlignmentRight;
        totalL.textColor = kAppColorAuxiliaryDeepOrange;
        NSString *price = isNull([orderMode.tradePrice stringValue]) == YES ? @"0.00":[NSString stringWithFormat:@"%.2f",[orderMode.tradePrice floatValue] / 100];
        totalL.text = [NSString stringWithFormat:@"¥ %@",price];
        [_totalView addSubview:totalL];
    }
    return _totalView;
}
@end
