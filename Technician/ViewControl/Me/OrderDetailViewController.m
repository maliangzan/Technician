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

static NSString *twoContentLabelCellID = @"TwoContentLabelCell";
static NSString *tableCellID = @"SYTableCell";
static NSString *twoLabelCellID = @"TwoLabelCell";
static NSString *addressCellID  = @"ServiceAddressCell";
static NSString *threeLabelCellID = @"ThreeLabelCell";
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceAddressCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) OrderHeadView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *totalView;
@end

@implementation OrderDetailViewController

- (instancetype)initWithOrderStadues:(SYOrderStadues)orderStadues{
    if ([super init]) {
        self.orderStadues = orderStadues;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void)configTableHeadView{
    switch (self.orderStadues) {
        case SYOrderStaduesAll:
        {
            [self.headView.toBeConfirmedBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forThePaymentBtn setImage:PNGIMAGE(@"102un_ing") forState:(UIControlStateNormal)];
            [self.headView.forTheServiceBtn setImage:PNGIMAGE(@"103un_ing") forState:(UIControlStateNormal)];
            [self.headView.completeBtn setImage:PNGIMAGE(@"104un_ing") forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesToBeConfirmed:
        {
            [self.headView.toBeConfirmedBtn setImage:PNGIMAGE(@"101ing") forState:(UIControlStateNormal)];
            [self.headView.forThePaymentBtn setImage:PNGIMAGE(@"102un_ing") forState:(UIControlStateNormal)];
            [self.headView.forTheServiceBtn setImage:PNGIMAGE(@"103un_ing") forState:(UIControlStateNormal)];
            [self.headView.completeBtn setImage:PNGIMAGE(@"104un_ing") forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesForThePayment:
        {
            [self.headView.toBeConfirmedBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forThePaymentBtn setImage:PNGIMAGE(@"102ing") forState:(UIControlStateNormal)];
            [self.headView.forTheServiceBtn setImage:PNGIMAGE(@"103un_ing") forState:(UIControlStateNormal)];
            [self.headView.completeBtn setImage:PNGIMAGE(@"104un_ing") forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesForTheService:
        {
            [self.headView.toBeConfirmedBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forThePaymentBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forTheServiceBtn setImage:PNGIMAGE(@"103ing") forState:(UIControlStateNormal)];
            [self.headView.completeBtn setImage:PNGIMAGE(@"104un_ing") forState:(UIControlStateNormal)];
        }
            break;
        case SYOrderStaduesComplete:
        {
            [self.headView.toBeConfirmedBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forThePaymentBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.forTheServiceBtn setImage:PNGIMAGE(@"100ing") forState:(UIControlStateNormal)];
            [self.headView.completeBtn setImage:PNGIMAGE(@"104ing") forState:(UIControlStateNormal)];
        }
            break;
            
        default:
            break;
    }
}

- (TwoContentLabelCell *)gettingTwoContentCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    TwoContentLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:twoContentLabelCellID];
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
        cell.addressLabel.text = dic[@"address"];
    }
    
    return cell;
}

- (ThreeLabelCell *)gettingThreeLabelInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    ThreeLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:threeLabelCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark ServiceAddressCellDelegate
- (void)contactUserAtCell:(ServiceAddressCell *)cell{
    [SVProgressHUD showErrorWithStatus:@"contactUserAtCell"];
}

- (void)locationTheAddressAtCell:(ServiceAddressCell *)cell{
    [SVProgressHUD showErrorWithStatus:@"locationTheAddressAtCell"];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
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
            if (self.orderStadues == SYOrderStaduesComplete){
                return [self gettingTableCellInTableView:tableView atIndexPath:indexPath];
            }else{
                return [self gettingTwoLabelCellInTableview:tableView atIndexPath:indexPath];
            }
            
        }
            break;
        case 2:
        {
            if (self.orderStadues == SYOrderStaduesComplete){
                return [self gettingTableCellInTableView:tableView atIndexPath:indexPath];
            }else{
                return [self gettingAddressCellInTableView:tableView atIndexPath:indexPath];
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
            if (self.orderStadues == SYOrderStaduesComplete) {
                return 30 * subArray.count;
            }else{
                //服务地
                NSDictionary *dic = subArray[0];
                return 100 + [NSString heightForString:dic[@"address"] labelWidth:KscreenWidth - 40 fontOfSize:15];
            }
        }
            break;
            
        default:
        {
            if (self.orderStadues == SYOrderStaduesComplete){
                return 30 * subArray.count;
            }else{
                return 44;
            }
            
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1 && self.orderStadues == SYOrderStaduesComplete) {
        //合计
        return self.totalView;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kAppColorBackground;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.dataArray.count - 1 && self.orderStadues == SYOrderStaduesComplete) {
        //合计view的高度
        return 35 * kHeightFactor;
    }
    return 10;
}
#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        switch (self.orderStadues) {
            case SYOrderStaduesAll:
            case SYOrderStaduesToBeConfirmed:
            case SYOrderStaduesForThePayment:
            case SYOrderStaduesForTheService:
            {
                _dataArray = [NSMutableArray arrayWithArray:
                              @[
                                //第一段 数组
                                @[@{@"title":@"其他要求：",
                                    @"content":@"要求要5年以上经验，懂病理知识。要按时上门，否则就取消订单。"}],
                                //第二段 数组
                                @[@{@"title":@"服务时间：",
                                    @"content":@"今天（周六）9：00"},
                                  ],
                                //第三段 数组
                                @[@{@"title":@"使用者：",
                                    @"content":@"赵默笙",
                                    @"sex":@"man",
                                    @"address":@"南山区前海路雷圳0755碧榕湾C-601"}
                                  ],
                                //第四段 数组
                                @[@{@"title":@"订单金额（含感谢费15元）：",@"content":@"568元"},
                                  ],
                                ]
                              ];
                
            }
                
                break;
            case SYOrderStaduesComplete:
            {
                _dataArray = [NSMutableArray arrayWithArray:
                              @[
                                //第一段 数组
                                @[@{@"title":@"其他要求：",
                                    @"content":@"要求要5年以上经验，懂病理知识。要按时上门，否则就取消订单。"}],
                                //第二段 数组
                                @[@{@"title":@"技师：",@"content":@"何以琛"},
                                  @{@"title":@"使用者：",@"content":@"赵默笙"},
                                  @{@"title":@"服务时间：",@"content":@"今天（周六）9：00"},
                                  @{@"title":@"开始时间：",@"content":@"今天（周六）9：00"},
                                  @{@"title":@"结束时间：",@"content":@"今天（周六）9：00"},
                                  @{@"title":@"实际时长：",@"content":@"73分钟"}],
                                //第三段 数组
                                @[@{@"title":@"订单编号：",@"content":@"1346187678341984731243"},
                                  @{@"title":@"交易流水号：",@"content":@"92084397584438"},
                                  @{@"title":@"创建时间：",@"content":@"今天（周六）9：00"},
                                  @{@"title":@"付款时间：",@"content":@"今天（周六）9：00"},
                                  @{@"title":@"确认时间：",@"content":@"今天（周六）9：00"}]
                                ]
                              ];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight + 10, KscreenWidth, KscreenHeight - kCustomNavHeight - 10) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        [self configTableHeadView];
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

- (UIView *)totalView{
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
        totalL.text = Localized(@"¥ 1674");
        [_totalView addSubview:totalL];
    }
    return _totalView;
}
@end
