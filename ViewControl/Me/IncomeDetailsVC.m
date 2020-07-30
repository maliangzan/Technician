//
//  IncomeDetailsVC.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "IncomeDetailsVC.h"
#import "IncomeDetailsBackView.h"
#import "SYDatePickerView.h"
#import "SYTimeHelper.h"
#import "SYIncomeDetailApi.h"
#import "SYIncomeDetailsMode.h"
#import "SYIncomeEarningMode.h"
#import "OrderDetailViewController.h"

@interface IncomeDetailsVC ()<IncomeDetailsBackViewDelegate>
@property (nonatomic,strong) IncomeDetailsBackView *incomeDetailsBackView;
@property (nonatomic,strong) SYDatePickerView *timeSetView;
@property (nonatomic,strong) UILabel *currentTimeLabel;
@property (nonatomic,strong) NSDate *beginTime;
@property (nonatomic,strong) NSDate *endTime;
@property (nonatomic,strong) SYIncomeDetailsMode *detailMode;
@property (nonatomic,assign) NSInteger selectMouth;

@end

@implementation IncomeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindData];
    [self loadDataByMouth];
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"收益明细";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.incomeDetailsBackView];
}

#pragma mark method
- (void)bindData{
    self.selectMouth = 0;
    NSTimeInterval oneyear = 24 * 60 * 60 * 365 * 60;
    self.beginTime = [[NSDate date] dateByAddingTimeInterval:-oneyear];
    self.endTime = [NSDate date];
}

- (void)loadDataByTime{
    NSString *beginTimeStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.beginTime];
    NSString *endTimeStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.endTime];
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsTechnicianEarning/getEarningDetail?tid=%@&beginTime=%@&endTime=%@",URL_HTTP_Base_Get,
                        [SYAppConfig shared].me.userID,
                        beginTimeStr,
                        endTimeStr
                        ];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlStr.length)];
    [self requestDataWithURL:urlStr];
}

- (void)loadDataByMouth{
//    NSString *beginTimeStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.beginTime];
//    NSString *endTimeStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.endTime];
    NSString *urlStr = [NSString stringWithFormat:
                  @"%@dsTechnicianEarning/getEarningDetail?tid=%@&months=%ld",URL_HTTP_Base_Get,
                  [SYAppConfig shared].me.userID,
                  self.selectMouth
                  ];
    
    [self requestDataWithURL:urlStr];
}

- (void)requestDataWithURL:(NSString *)urlStr{
    WeakSelf;
    SYIncomeDetailApi *api = [[SYIncomeDetailApi alloc] initWithUrl:urlStr];
    [ProgressHUD show:Localized(@"正在拼命加载，请稍后...")];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [ProgressHUD dismiss];
        weakself.detailMode = [SYIncomeDetailsMode fromJSONDictionary:request.responseObject[@"data"]];
        [weakself freshData];
        
        [weakself.incomeDetailsBackView.collectionView reloadData];
        
    } failure:^(YTKBaseRequest *request) {
        [ProgressHUD dismiss];
        [weakself.view hideHUD];
        NSLog(@"%@", request.error);
    }];
}

- (void)freshData{
    [self.incomeDetailsBackView configTitleLabelWithMode:self.detailMode];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in self.detailMode.earnings) {
        SYIncomeEarningMode *earningMode = [SYIncomeEarningMode fromJSONDictionary:dic];
        [array addObject:earningMode];
    }
    self.incomeDetailsBackView.dataArray = array;
}

#pragma mark IncomeDetailsBackViewDelegate
- (void)selectBeginTime{
    self.incomeDetailsBackView.beginTimeLabel.tag = 200;
    self.currentTimeLabel = self.incomeDetailsBackView.beginTimeLabel;
    [self.timeSetView show];
}

- (void)selectEndTime{
    self.incomeDetailsBackView.endTimeLabel.tag = 201;
    self.currentTimeLabel = self.incomeDetailsBackView.endTimeLabel;
    [self.timeSetView show];
}

- (void)selectMouthButtonAtIndex:(NSInteger)index{
    switch (index) {
        case 0://0全部
        {
            self.selectMouth = 0;
        }
            break;
        case 1://1一个月
        {
            self.selectMouth = 1;
        }
            break;
        case 2://2三个月
        {
            self.selectMouth = 3;
        }
            break;
        case 3://3半年
        {
            self.selectMouth = 6;
        }
            break;
        case 4://4一年
        {
            self.selectMouth = 12;
        }
            break;
            
        default:
            break;
    }
    [self loadDataByMouth];
}

- (void)showDetailWithMode:(SYIncomeEarningMode *)mode{
    
    SYOrderMode *orderMode = [SYOrderMode fromJSONDictionary:mode.order];
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] initWithMyOrderMode:orderMode];
    [self.navigationController pushViewController:orderVC animated:YES];
    
}

#pragma mark 懒加载
- (IncomeDetailsBackView *)incomeDetailsBackView{
    if (!_incomeDetailsBackView) {
        [self bindData];
        _incomeDetailsBackView = [[NSBundle mainBundle] loadNibNamed:@"IncomeDetailsBackView" owner:nil options:nil][0];
        _incomeDetailsBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _incomeDetailsBackView.delegate = self;
//        NSString *beginTime = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.beginTime];
//        NSString *endTime = [SYTimeHelper niceDateFrom_YYYY_MM_DD:self.endTime];
        //        _incomeDetailsBackView.beginTimeLabel.text = beginTime;
        //        _incomeDetailsBackView.endTimeLabel.text = endTime;
    }
    return _incomeDetailsBackView;
}
- (SYDatePickerView *)timeSetView {
    if (_timeSetView == nil) {
        
        _timeSetView = [SYDatePickerView allocWithNibSameClassName];
        _timeSetView.titleLabel.text = Localized(@"请选择时间");
        WeakSelf;
        _timeSetView.datePicked = ^(NSDate *date) {
            NSString *dateStr = [SYTimeHelper niceDateFrom_YYYY_MM_DD:date];
            
            if (weakself.currentTimeLabel.tag == 200) {
                weakself.beginTime = date;
            }else if(weakself.currentTimeLabel.tag == 201){
                weakself.endTime = date;
                if ([SYTimeHelper niceDateFrom_YYYY_MM_DD:weakself.beginTime].length == 0) {
                    [weakself.view showHUDForError:Localized(@"请选择开始时间")];
                    return ;
                }
                
                
                //                NSTimeInterval time = compareStrDate(weakself.start_time, weakself.end_time);
                
                //                if (time > 0) {
                //                    [weakself.view showHUDOnlyMessage:lls(@"结束时间不能早于开始时间")];
                //                    return;
                //                }else if (time == 0){
                //                    [weakself.view showHUDOnlyMessage:lls(@"结束时间不能等于开始时间")];
                //                    return;
                //                }
                //                NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
                //                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                //                NSString *currentTime = [formatter stringFromDate:[NSDate date]];
                //
                //                NSTimeInterval time2 = compareStrDate(currentTime, weakself.end_time);
                //
                //                if (time2 > 0) {
                //                    [weakself.view showHUDOnlyMessage:lls(@"结束时间不能早于当前时间")];
                //                    return;
                //                }else if (time2 == 0){
                //                    [weakself.view showHUDOnlyMessage:lls(@"结束时间不能等于当前时间")];
                //                    return;
                //                }
            }
            [weakself loadDataByTime];
            weakself.currentTimeLabel.text = dateStr;
            
        };
    }
    return _timeSetView;
}

@end
