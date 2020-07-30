//
//  ServiceTimeViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceTimeViewController.h"
#import "ServiceTimeBackView.h"
#import "SYEndServiceApi.h"
#import "SY_GCDTimerManager.h"
#import "SYServiceTimeCountApi.h"

static NSString *timerName = @"myTimer";
@interface ServiceTimeViewController ()<ServiceTimeBackViewDelegate>
@property (nonatomic,strong) ServiceTimeBackView *serviceTimeBackView;
@property (nonatomic,strong) SYNearbyOrderMode *nearbyOrderMode;
@property (nonatomic,strong) SYOrderMode *orderMode;
@property (nonatomic,assign) NSInteger serviceTime;

@end

@implementation ServiceTimeViewController

- (instancetype)initWithMode:(SYNearbyOrderMode *)mode{
    if (self = [super init]) {
        self.nearbyOrderMode = mode;
        self.orderMode = [SYOrderMode fromJSONDictionary:self.nearbyOrderMode.order];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObserveNotification(kNotificationApplicationDidBecomeActive, @selector(appBecomeActive));
    
    [self bindData];
    [self leadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc{
    [[SY_GCDTimerManager sharedInstance] cancelTimerWithName:timerName];
}

- (void)appBecomeActive{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:isEndTheServiceTime]) {
        [self leadData];
    }
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"服务时间";
    __block typeof(self) weakSelf = self;
    self.leftBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.serviceTimeBackView];

}

#pragma mark method
- (void)bindData{
    self.serviceTime = 90;
}

- (void)leadData{
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/timeCount?id=%@",
                        URL_HTTP_Base_Get,
                        self.orderMode.orderID//oid
                        ];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"正在获取服务时间,请稍后...")];
    SYServiceTimeCountApi *api = [[SYServiceTimeCountApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        
        for (NSString *keyString in [request.responseObject[@"data"] allKeys]) {
            if ([keyString isEqualToString:@"standardTime"]) {
                NSString *serviceTimeString = request.responseObject[@"data"][@"standardTime"];
                weakself.serviceTime =  [serviceTimeString integerValue];
            }
        }
        weakself.serviceTimeBackView.totalTimeLabel.text = [NSString stringWithFormat:@"%ld分",weakself.serviceTime];
        NSNumber *hNum = request.responseObject[@"data"][@"timeCount"][@"hh"];
        if (hNum < 0) {
            hNum = 0;
        }
        NSNumber *mNum = request.responseObject[@"data"][@"timeCount"][@"mm"];
        if (mNum < 0) {
            mNum = 0;
        }
        NSNumber *sNum = request.responseObject[@"data"][@"timeCount"][@"ss"];
        if (sNum < 0) {
            sNum = 0;
        }
        [weakself showTimeWithHour:hNum min:mNum second:sNum];
        [weakself configTimeWithHour:hNum min:mNum second:sNum];
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"获取服务时间失败，连接不到服务器！")];
        [weakself showTimeWithHour:@0 min:@0 second:@0];
        [weakself configTimeWithHour:@0 min:@0 second:@0];
        NSLog(@"%@", request.error);
    }];
}

- (void)configTimeWithHour:(NSNumber *)hNum min:(NSNumber *)mNum second:(NSNumber *)sNum{
    __block NSInteger hInt = [hNum integerValue];
    __block NSInteger mInt = [mNum  integerValue];
    __block NSInteger sInt = [sNum  integerValue];
    if ((hInt * 60 + mInt + (sInt / 60)) >= self.serviceTime) {
        //服务时间到，自动结束服务
        [[UIApplication sharedApplication].keyWindow showHUDForError:Localized(@"服务时间已到，服务自动结束！")];
        [self endService];
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isEndTheServiceTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    WeakSelf;
    [[SY_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:timerName timeInterval:1.0 queue:dispatch_get_main_queue() repeats:YES action:^{
        if (sInt < 59) {
            sInt = sInt + 1;
        }else {
            sInt = 0;
            if (mInt < 59) {
                mInt = mInt + 1;
            }else{
                mInt = 0;
                hInt = hInt + 1;
            }
        }
        if ((hInt * 60 + mInt + sInt / 60) >= weakself.serviceTime) {
            //客户端服务时间到，服务自动结束
            [weakself endService];
            return ;
        }
        NSNumber * hhNum = [NSNumber numberWithInteger:hInt];
        NSNumber * mmNum = [NSNumber numberWithInteger:mInt];
        NSNumber * ssNum = [NSNumber numberWithInteger:sInt];
        
        
        
        [weakself showTimeWithHour:hhNum min:mmNum second:ssNum];
    }];
}

- (void)showTimeWithHour:(NSNumber *)hNum min:(NSNumber *)mNum second:(NSNumber *)sNum{
    NSInteger hhInt = [hNum integerValue];
    NSInteger mmInt = [mNum integerValue];
    NSInteger ssInt = [sNum integerValue];
    NSString *hhString= [NSString stringWithFormat:@"%ld",hhInt];
    NSString *mmString= [NSString stringWithFormat:@"%ld",mmInt];
    NSString *ssString= [NSString stringWithFormat:@"%ld",ssInt];
    if (hhString.length == 1) {
        hhString = [NSString stringWithFormat:@"0%@",hhString];
    }
    if (mmString.length == 1) {
        mmString = [NSString stringWithFormat:@"0%@",mmString];
    }
    if (ssString.length == 1) {
        ssString = [NSString stringWithFormat:@"0%@",ssString];
    }
    self.serviceTimeBackView.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hhString,mmString,ssString];
}

- (void)endService{

    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/setEndTime?id=%@",
                        URL_HTTP_Base_Get,
                        self.orderMode.orderID//oid
                        ];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"正在结束服务，请稍后...")];
    SYEndServiceApi *api = [[SYEndServiceApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        NSInteger endCode = [request.responseObject[@"code"] integerValue];
        if (endCode == 0) {
            [[SY_GCDTimerManager sharedInstance] cancelTimerWithName:timerName];
            [weakself.navigationController popViewControllerAnimated:YES];
            PostNotificationWithName(kNotificationServiceTimeViewControllerEndTimeSuccess);
            PostNotificationWithName(kNotificationOrderListBaseViewControllerRefresh);
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isEndTheServiceTime];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else if (endCode == 1) {
            [weakself.view showHUDForError:Localized(@"结束服务失败")];
        }else if (endCode == 2){
            [weakself.view showHUDForError:Localized(@"订单状态错误")];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
    
}

#pragma mark ServiceTimeBackViewDelegate
- (void)overTheTime{
    NSString *urlStr = [NSString stringWithFormat:
                        @"%@dsSaleOrder/timeCount?id=%@",
                        URL_HTTP_Base_Get,
                        self.orderMode.orderID//oid
                        ];
    WeakSelf;
    [self.view showHUDWithMessage:Localized(@"")];
    SYServiceTimeCountApi *api = [[SYServiceTimeCountApi alloc] initWithUrl:urlStr];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        NSNumber *hNum = request.responseObject[@"data"][@"timeCount"][@"hh"];
        if (hNum < 0) {
            hNum = 0;
        }
        NSNumber *mNum = request.responseObject[@"data"][@"timeCount"][@"mm"];
        if (mNum < 0) {
            mNum = 0;
        }
        NSNumber *sNum = request.responseObject[@"data"][@"timeCount"][@"ss"];
        if (sNum < 0) {
            sNum = 0;
        }
        NSInteger actTotalTime = 60 * [hNum integerValue] + [mNum integerValue] + [sNum integerValue] / 60;
        
        if (actTotalTime < self.serviceTime) {
            [weakself timeIsOff];
        } else {
            [weakself endService];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [weakself.view hideHUD];
        [weakself.view showHUDForError:Localized(@"获取服务时间失败，连接不到服务器！")];
        NSLog(@"%@", request.error);
    }];
    
    
}

- (void)timeIsOff{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"时间未到！"),Localized(@"服务时间未到，是否继续结束？") , Localized(@"等等"), Localized(@"是")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            [weakself endService];
        }
    }] show];
}

#pragma mark 懒加载
- (ServiceTimeBackView *)serviceTimeBackView{
    if (!_serviceTimeBackView) {
        _serviceTimeBackView = [[[NSBundle mainBundle] loadNibNamed:@"ServiceTimeBackView" owner:nil options:nil] objectAtIndex:0];
        _serviceTimeBackView.delegate = self;
        _serviceTimeBackView.frame = CGRectMake(0, kCustomNavHeight, KscreenWidth, KscreenHeight - kCustomNavHeight);
    }
    return _serviceTimeBackView;
}

@end
