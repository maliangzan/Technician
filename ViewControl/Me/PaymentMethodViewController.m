//
//  PaymentMethodViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/12.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "PaymentMethodViewController.h"
#import "PaymentToBankViewController.h"
#import "SYQueryWithdrawalRecordApi.h"
#import "SYAccountMode.h"

#define HEAD_HEIGHT 40 * kHeightFactor
#define CELL_HEIGHT 50 * kHeightFactor

@interface PaymentMethodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *recordArray;
@property (nonatomic,strong) NSMutableArray *methodArray;
@property (nonatomic,strong) NSMutableArray *accountArray;
@end

@implementation PaymentMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}
- (void)buildUI{
    [super buildUI];
    
    self.titleLabel.text = Localized(@"选择收款方式");
    
    WeakSelf;
    self.leftBtn = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
    self.moreBtn.hidden = YES;
    
    [self.view addSubview:self.tableView];
}

#pragma mark method
- (void)loadData{

    WeakSelf;
    [[[SYQueryWithdrawalRecordApi alloc] init]
              startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                  [[UIApplication sharedApplication].keyWindow hideHUD];
                  if ([request isSuccess]) {
                      [weakself.accountArray removeAllObjects];
                      for (NSDictionary *dic in request.responseObject[@"data"]) {
                          SYAccountMode *accountMode = [SYAccountMode fromJSONDictionary:dic[@"account"]];
                          [weakself.accountArray addObject:accountMode];
                      }

                      [weakself.tableView reloadData];
                      
                  } else if ([request isCommonErrorAndHandle]) {
                      return ;
                  } else {
                      [[UIApplication sharedApplication].keyWindow showHUDForError:request.businessErrorMessage];
                  }
              } failure:^(YTKBaseRequest *request) {
                  [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"连接不到服务器")];
              }];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArray = [self.dataArray objectAtIndex:section];
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle      reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 1, KscreenWidth, 1)];
    line.backgroundColor = kAppColorBackground;
    [cell.contentView addSubview:line];
    
    NSArray *subArray = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dic = subArray[indexPath.row];
    cell.imageView.image = PNGIMAGE(dic[@"icon"]);
    cell.textLabel.textColor = kAppColorTextMiddleBlack;
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.textColor = kAppColorTextLightBlack;
    cell.detailTextLabel.text = dic[@"subTitle"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.text = Localized(@"    历史");
    label.textColor = kAppColorTextLightBlack;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //zfb、wx、bank
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    if ([dic[@"accountType"] isEqualToString:@"zfb"]) {
        //支付宝支付
        
    } else if ([dic[@"accountType"] isEqualToString:@"wx"]) {
        //微信支付
        
    }else if ([dic[@"accountType"] isEqualToString:@"bank"]) {
        //银联支付
        
        switch (indexPath.section) {
            case 0:
            {
                PaymentToBankViewController *bankVC = [[PaymentToBankViewController alloc] initWithIncomeType:SYInComeTypeTheCommonlyUsed accountMode:nil];
                [self.navigationController pushViewController:bankVC animated:YES];
            }
                break;
            case 1:
            {
                SYAccountMode *mode = [self.accountArray objectAtIndex:indexPath.row];
                PaymentToBankViewController *bankVC = [[PaymentToBankViewController alloc] initWithIncomeType:SYInComeTypeTheHistoricalRecord accountMode:mode];
                [self.navigationController pushViewController:bankVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight) style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.tableHeaderView = self.headView;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, HEAD_HEIGHT)];
        _headView.backgroundColor = kAppColorBackground;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KscreenWidth - 40, HEAD_HEIGHT)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.text = Localized(@"为了保障您的财产安全，只能使用您本人的银行卡或账号提现。");
        label.textColor = kAppColorTextLightBlack;
        [_headView addSubview:label];
    }
    return _headView;
}

- (NSMutableArray *)dataArray{
    _dataArray = [NSMutableArray arrayWithObjects:self.methodArray,self.recordArray, nil];
    return _dataArray;
}

- (NSMutableArray *)methodArray{
//    @{@"icon":@"img_wechat",@"title":@"提现到微信钱包",@"subTitle":@"",@"accountType":@"wx"},
//    @{@"icon":@"img_pay",@"title":@"提现到支付宝",@"subTitle":@"",@"accountType":@"zfb"},
    if (!_methodArray) {
        _methodArray = [NSMutableArray arrayWithArray:@[
                                                        
                                                        @{@"icon":@"img_bankCard",@"title":@"提现到银行卡",@"subTitle":@"",@"accountType":@"bank"}
                                                        ]
                        ];;
    }
    return _methodArray;
}

- (NSMutableArray *)recordArray{
    [_recordArray removeAllObjects];
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    for (SYAccountMode *accountMode in self.accountArray) {
        NSString *titleString = isNull(accountMode.accountName) == YES ? @"" : accountMode.accountName;
        titleString = [NSString stringWithFormat:@"%@(%@)",titleString,accountMode.bankName];
        NSString *subTitleString = isNull(accountMode.accountNo ) == YES ?@"":accountMode.accountNo;
        NSString *starString = @"*";
        
        if (subTitleString.length > 8) {
            for (int i = 0; i < subTitleString.length - 8 - 1; i++) {
                starString = [NSString stringWithFormat:@"%@*",starString];
            }
            
            subTitleString = [subTitleString stringByReplacingCharactersInRange:NSMakeRange(4, subTitleString.length - 8) withString:starString];
        }
        if (accountMode) {
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
            //头像zfb、wx、bank
            if ([accountMode.accountType isEqualToString:@"zfb"]) {
                //支付宝头像
                [mutDic setObject:@"img_pay" forKey:@"icon"];
            } else if ([accountMode.accountType isEqualToString:@"wx"]){
                //微信头像
                [mutDic setObject:@"img_wechat" forKey:@"icon"];
            }else if ([accountMode.accountType isEqualToString:@"bank"]){
                //银联头像
                [mutDic setObject:@"img_bankCard" forKey:@"icon"];
            }
            //姓名
            [mutDic setObject:titleString forKey:@"title"];
            //显示内容
            [mutDic setObject:subTitleString forKey:@"subTitle"];
            //收款方式
            [mutDic setObject:accountMode.accountType forKey:@"accountType"];
            [_recordArray addObject:mutDic];
        }
    }
    
    return _recordArray;
}

- (NSMutableArray *)accountArray{
    if (!_accountArray) {
        _accountArray = [NSMutableArray array];
    }
    return _accountArray;
}

@end
