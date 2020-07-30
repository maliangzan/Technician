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

static NSString *twoContentLabelCellID = @"TwoContentLabelCell";
static NSString *addressCellID  = @"ServiceAddressCell";
static NSString *threeLabelCellID = @"ThreeLabelCell";
static NSString *twoLabelCellID = @"TwoLabelCell";
static NSString *orderBtnCellID = @"OrdersBtnCell";
@interface ServiceDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceAddressCellDelegate,OrdersBtnCellDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong) OrderHeadView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ServiceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        _tableView.tableHeaderView = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:twoContentLabelCellID bundle:nil] forCellReuseIdentifier:twoContentLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:addressCellID bundle:nil] forCellReuseIdentifier:addressCellID];
        [_tableView registerNib:[UINib nibWithNibName:threeLabelCellID bundle:nil] forCellReuseIdentifier:threeLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:twoLabelCellID bundle:nil] forCellReuseIdentifier:twoLabelCellID];
        [_tableView registerNib:[UINib nibWithNibName:orderBtnCellID bundle:nil] forCellReuseIdentifier:orderBtnCellID];
    }
    return _tableView;
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

- (OrdersBtnCell *)gettingOrderBtnCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    OrdersBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:orderBtnCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

#pragma mark OrdersBtnCellDelegate
- (void)acceptOrder{
    [[SYAlertViewTwo(@"已成功接单", @"请及时安排好上门时间。出门前请务必提前和客户电话确认。祝您工作愉快！", @"取消", @"确定") setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        
    }] show];
}

#pragma mark ServiceAddressCellDelegate
- (void)contactUserAtCell:(ServiceAddressCell *)cell{
    [SVProgressHUD showErrorWithStatus:@"contactUserAtCell"];
}

- (void)locationTheAddressAtCell:(ServiceAddressCell *)cell{
    [SVProgressHUD showErrorWithStatus:@"locationTheAddressAtCell"];
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
    if (!_dataArray) {
        
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
                        //第五段 数组
                        @[@{@"title":@" 5: 59 马上接单"},
                          ],
                        ]
                      ];
        
        
        
    }
    return _dataArray;
}

@end
