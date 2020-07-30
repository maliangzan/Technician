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

@interface IncomeDetailsVC ()<IncomeDetailsBackViewDelegate>
@property (nonatomic,strong) IncomeDetailsBackView *incomeDetailsBackView;
@property (nonatomic,strong) SYDatePickerView *timeSetView;
@property (nonatomic,strong) UILabel *currentTimeLabel;
@property (nonatomic,copy) NSString *beginTime;
@property (nonatomic,copy) NSString *endTime;


@end

@implementation IncomeDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)showDetailForOrderNum:(NSInteger)index{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"查看订单%ld",index]];
}

#pragma mark 懒加载
- (IncomeDetailsBackView *)incomeDetailsBackView{
    if (!_incomeDetailsBackView) {
        _incomeDetailsBackView = [[NSBundle mainBundle] loadNibNamed:@"IncomeDetailsBackView" owner:nil options:nil][0];
        _incomeDetailsBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
        _incomeDetailsBackView.delegate = self;
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
                weakself.beginTime = dateStr;
            }else if(weakself.currentTimeLabel.tag == 201){
                weakself.endTime = dateStr;
                if (weakself.beginTime.length == 0) {
                    [SVProgressHUD showWithStatus:Localized(@"请选择开始时间")];
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
            weakself.currentTimeLabel.text = dateStr;
        };
    }
    return _timeSetView;
}

@end
