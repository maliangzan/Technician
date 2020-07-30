//
//  ServiceTimeViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/17.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "ServiceTimeViewController.h"
#import "ServiceTimeBackView.h"

@interface ServiceTimeViewController ()<ServiceTimeBackViewDelegate>
@property (nonatomic,strong) ServiceTimeBackView *serviceTimeBackView;
@end

@implementation ServiceTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark ServiceTimeBackViewDelegate
- (void)overTheTime{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"时间未到！"),Localized(@"服务时间未到，是否继续结束？") , Localized(@"等等"), Localized(@"是")) setCompleteBlock:^(UIAlertView *alertView, NSInteger index) {
        if (index == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
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
